Vue.component("message", {
  template: "#message_template",
  data() {
    return {};
  },
  computed: {
    textEscaped() {
      let s = this.template ? this.template : this.templates[this.templateId];

      if (this.template) {
        //We disable templateId since we are using a direct raw template
        this.templateId = -1;
      }

      //This hack is required to preserve backwards compatability
      if (
        this.templateId == CONFIG.defaultTemplateId &&
        this.args.length == 1
      ) {
        s = this.templates[CONFIG.defaultAltTemplateId]; //Swap out default template :/
      }

      s = s.replace(/{(\d+)}/g, (match, number) => {
        const argEscaped =
          this.args[number] != undefined
            ? this.escape(this.args[number])
            : match;
        if (number == 0 && this.color) {
          if (this.color == 1) {
            var now = new Date();
            var dob = new Date(this.args.birthdate);
            var Fname = this.args.firstname;
            var Lname = this.args.lastname;
            var sex = this.args.gender;
            var identifier = this.args.nationality;
            var pref = this.args.citizenid;
            console.log(Fname + Lname)
            // console.log(this.args.Name)
            // console.log(this.args.DOB)

            return `<div class="license">
            <div class="license__state">Catena</div>
              <div class="license__signature">${Fname} ${Lname}</div>
              <div class="license__photo license__photo--${sex}"></div>
              <div class="license__row license__row--red license__row--pref">${pref}</div>
              <div class="license__row license__row--red license__row--exp">${dob.getMonth() + 1}/${dob.getDate() + 1}/${now.getFullYear() + 1}</div>
              <div class="license__row license__row--last">${Lname}</div>
              <div class="license__row license__row--first">${Fname}</div>
              <div class="license__row license__row--small license__row--address">123 Fake St<br>Los Santos, GTAV 42069</div>
              <div class="license__row license__row--red license__row--dob">${dob.getMonth() + 1}/${dob.getDate() + 1}/${dob.getFullYear()}</div>
              <div class="license__row license__row--rstr">None</div>
              <div class="license__row license__row--class">C</div>
              <div class="license__row license__row--end">None</div>
              <div class="license__row license__row--small license__row--sex">${sex}</div>
              <div class="license__row license__row--tiny license__row--cref">${identifier}</div>
              <div class="license__row license__row--small license__row--eyes">Green</div>
              <div class="license__row license__row--small license__row--iss">04/01/2019</div>
            </div>`;
          }
          if (this.color == 2) {
            var now = new Date();
            var dob = new Date(this.args.birthdate);
            var Fname = this.args.firstname;
            var Lname = this.args.lastname;
            var sex = this.args.gender;
            var identifier = this.args.type;
            console.log(Fname + Lname)
            // console.log(this.args.Name)
            // console.log(this.args.DOB)

            return `<div class="license2">
            <div class="license__state">Catena</div>
              <div class="license__signature">${Fname} ${Lname}</div>
              <div class="license__photo license__photo--0"></div>
              <div class="license__row license__row--red license__row--exp">${dob.getMonth() + 1}/${dob.getDate() + 1}/${now.getFullYear() + 1}</div>
              <div class="license__row license__row--last">${Lname}</div>
              <div class="license__row license__row--first">${Fname}</div>
              <div class="license__row license__row--small license__row--address">123 Fake St<br>Los Santos, GTAV 42069</div>
              <div class="license__row license__row--red license__row--dob">${dob.getMonth() + 1}/${dob.getDate() + 1}/${dob.getFullYear()}</div>
              <div class="license__row license__row--class">C</div>
              <div class="license__row license__row--end">None</div>
              <div class="license__row license__row--small license__row--hgt">5'-03"</div>
              <div class="license__row license__row--tiny license__row--cref">${identifier}</div>
            </div>`;
          }
          //color is deprecated, use templates or ^1 etc.
          return this.colorizeOld(argEscaped);
        }
        return argEscaped;
      });
      return this.colorize(s);
    }
  },
  methods: {
    colorizeOld(str) {
      return `<span style="color: rgb(${this.color[0]}, ${this.color[1]}, ${
        this.color[2]
      })">${str}</span>`;
    },
    colorize(str) {
      let s =
        "<span>" +
        str.replace(
          /\^([0-9])/g,
          (str, color) => `</span><span class="color-${color}">`
        ) +
        "</span>";

      const styleDict = {
        "*": "font-weight: bold;",
        _: "text-decoration: underline;",
        "~": "text-decoration: line-through;",
        "=": "text-decoration: underline line-through;",
        r: "text-decoration: none;font-weight: normal;"
      };

      const styleRegex = /\^(\_|\*|\=|\~|\/|r)(.*?)(?=$|\^r|<\/em>)/;
      while (s.match(styleRegex)) {
        //Any better solution would be appreciated :P
        s = s.replace(
          styleRegex,
          (str, style, inner) => `<em style="${styleDict[style]}">${inner}</em>`
        );
      }
      return s.replace(/<span[^>]*><\/span[^>]*>/g, "");
    },
    escape(unsafe) {
      return String(unsafe)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
    }
  },
  props: {
    templates: {
      type: Object
    },
    args: {
      type: Array
    },
    template: {
      type: String,
      default: null
    },
    templateId: {
      type: String,
      default: CONFIG.defaultTemplateId
    },
    multiline: {
      type: Boolean,
      default: false
    },
    color: {
      //deprecated
      type: Array,
      default: false
    }
  }
});
