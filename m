Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1529944823-22228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529944823-22228-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Jul 2018 13:02:11 +0900
Message-ID: <CAK7LNAQ_8k3k3qA2jL3PBpKz6smRAdqUvJR9v9QF=xpFH_G+Xw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move bin2c back to scripts/ from scripts/basic/
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-s390 <linux-s390@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, X86 ML <x86@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>, Paul Mackerras <paulus@samba.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-security-module@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2018-06-26 1:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Commit 8370edea81e3 ("bin2c: move bin2c in scripts/basic") moved bin2c
> to the scripts/basic/ directory, incorrectly stating "Kexec wants to
> use bin2c and it wants to use it really early in the build process.
> See arch/x86/purgatory/ code in later patches."
>
> Commit bdab125c9301 ("Revert "kexec/purgatory: Add clean-up for
> purgatory directory"") and commit d6605b6bbee8 ("x86/build: Remove
> unnecessary preparation for purgatory") removed the redundant
> purgatory build magic entirely.
>
> That means that the move of bin2c was unnecessary in the first place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild.


>
>  arch/powerpc/purgatory/Makefile | 3 +--
>  arch/s390/purgatory/Makefile    | 3 +--
>  arch/x86/purgatory/Makefile     | 3 +--
>  kernel/Makefile                 | 2 +-
>  scripts/.gitignore              | 1 +
>  scripts/Makefile                | 1 +
>  scripts/basic/.gitignore        | 1 -
>  scripts/basic/Makefile          | 1 -
>  scripts/{basic => }/bin2c.c     | 0
>  security/tomoyo/Makefile        | 2 +-
>  10 files changed, 7 insertions(+), 10 deletions(-)
>  rename scripts/{basic => }/bin2c.c (100%)
>
> diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
> index 30e05de..4314ba5 100644
> --- a/arch/powerpc/purgatory/Makefile
> +++ b/arch/powerpc/purgatory/Makefile
> @@ -6,9 +6,8 @@ LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
>  $(obj)/purgatory.ro: $(obj)/trampoline.o FORCE
>                 $(call if_changed,ld)
>
> -CMD_BIN2C = $(objtree)/scripts/basic/bin2c
>  quiet_cmd_bin2c = BIN2C   $@
> -      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
> +      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
>
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
>         $(call if_changed,bin2c)
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index 1ace023..445c460 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -27,9 +27,8 @@ KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
>
> -CMD_BIN2C = $(objtree)/scripts/basic/bin2c
>  quiet_cmd_bin2c = BIN2C   $@
> -      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
> +      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
>
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
>         $(call if_changed,bin2c)
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 2e9ee02..d6ac098 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -28,9 +28,8 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>
>  targets += kexec-purgatory.c
>
> -CMD_BIN2C = $(objtree)/scripts/basic/bin2c
>  quiet_cmd_bin2c = BIN2C   $@
> -      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
> +      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
>
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
>         $(call if_changed,bin2c)
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 04bc07c..7a63d56 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -123,7 +123,7 @@ targets += config_data.gz
>  $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
>         $(call if_changed,gzip)
>
> -      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/basic/bin2c; echo "MAGIC_END;")
> +      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;")
>  targets += config_data.h
>  $(obj)/config_data.h: $(obj)/config_data.gz FORCE
>         $(call filechk,ikconfiggz)
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 0442c06..12d302d 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,6 +1,7 @@
>  #
>  # Generated files
>  #
> +bin2c
>  conmakehash
>  kallsyms
>  pnmtologo
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 25ab143..59c21ec 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -10,6 +10,7 @@
>
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>
> +hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
>  hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
>  hostprogs-$(CONFIG_LOGO)         += pnmtologo
>  hostprogs-$(CONFIG_VT)           += conmakehash
> diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
> index 9528ec9..a776371 100644
> --- a/scripts/basic/.gitignore
> +++ b/scripts/basic/.gitignore
> @@ -1,2 +1 @@
>  fixdep
> -bin2c
> diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
> index 0372b33..af49b44 100644
> --- a/scripts/basic/Makefile
> +++ b/scripts/basic/Makefile
> @@ -9,7 +9,6 @@
>  # fixdep:       Used to generate dependency information during build process
>
>  hostprogs-y    := fixdep
> -hostprogs-$(CONFIG_BUILD_BIN2C)     += bin2c
>  always         := $(hostprogs-y)
>
>  # fixdep is needed to compile other host programs
> diff --git a/scripts/basic/bin2c.c b/scripts/bin2c.c
> similarity index 100%
> rename from scripts/basic/bin2c.c
> rename to scripts/bin2c.c
> diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
> index b7c6a7f..cca5a30 100644
> --- a/security/tomoyo/Makefile
> +++ b/security/tomoyo/Makefile
> @@ -4,7 +4,7 @@ obj-y = audit.o common.o condition.o domain.o environ.o file.o gc.o group.o load
>  targets += builtin-policy.h
>  define do_policy
>  echo "static char tomoyo_builtin_$(1)[] __initdata ="; \
> -$(objtree)/scripts/basic/bin2c <$(firstword $(wildcard $(obj)/policy/$(1).conf $(srctree)/$(src)/policy/$(1).conf.default) /dev/null); \
> +$(objtree)/scripts/bin2c <$(firstword $(wildcard $(obj)/policy/$(1).conf $(srctree)/$(src)/policy/$(1).conf.default) /dev/null); \
>  echo ";"
>  endef
>  quiet_cmd_policy  = POLICY  $@
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
