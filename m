Return-Path: <linux-kernel-owner+w=401wt.eu-S1756742AbYG1T2w@vger.kernel.org>
Date: Mon, 28 Jul 2008 21:28:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 02/15] kmsg: Kernel message catalog script.
Message-ID: <20080728192828.GA11431@uranus.ravnborg.org>
References: <20080728175355.734299984@de.ibm.com> <20080728175511.260174666@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080728175511.260174666@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> 
> The kmsg man page creation is invoked with "make K=2" and reads the source
> files for all built objects, looks up the message description and writes
> a man page to $(objtree)/man.
Can we use M=2 instead of K=?
I have sort of reserved 'K' for Kconfig usage.

> Index: quilt-2.6/scripts/Makefile.build
> ===================================================================
> --- quilt-2.6.orig/scripts/Makefile.build
> +++ quilt-2.6/scripts/Makefile.build
> @@ -211,12 +211,14 @@ endef
>  # Built-in and composite module parts
>  $(obj)/%.o: $(src)/%.c FORCE
>  	$(call cmd,force_checksrc)
> +	$(call cmd,force_check_kmsg)
>  	$(call if_changed_rule,cc_o_c)
>  
>  # Single-part modules are special since we need to mark them in $(MODVERDIR)
>  
>  $(single-used-m): $(obj)/%.o: $(src)/%.c FORCE
>  	$(call cmd,force_checksrc)
> +	$(call cmd,force_check_kmsg)
>  	$(call if_changed_rule,cc_o_c)
>  	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
>  
> @@ -339,6 +341,19 @@ $(multi-used-m) : %.o: $(multi-objs-m) F
>  
>  targets += $(multi-used-y) $(multi-used-m)
>  
> +# kmsg check tool
> +ifneq ($(KBUILD_KMSG_CHECK),0)
> +  ifeq ($(KBUILD_KMSG_CHECK),2)
> +    kmsg_cmd = print
> +    quiet_cmd_force_check_kmsg = KMSG_PRINT $<
> +    $(shell [ -d $(objtree)/man ] || mkdir -p $(objtree)/man)
> +  else
> +    kmsg_cmd = check
> +    quiet_cmd_force_check_kmsg = KMSG_CHECK $<
> +  endif
> +  cmd_force_check_kmsg = SRCTREE=$(srctree) OBJTREE=$(objtree) \
> +			$(KMSG_CHECK) $(kmsg_cmd) $(CC) $(c_flags) $< ;
> +endif
We are executing with $(objtree) as current directory so no need
to specify $(objtree) in the above.

You can used non-recursive assignments for kmsg_cmd (use ':=').

Do you really need the uppercase SRCTREE, OBJTREE?
Other scripts uses the lower cases variants direct.

	Sam
