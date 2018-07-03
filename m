From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 4/8] x86: add support for 64-bit place relative
 relocations
Date: Tue, 3 Jul 2018 15:31:47 +0800
Message-ID: <201807031304.9Y2r6crU%fengguang.wu@intel.com>
References: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-jump-tables/20180703-031712
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   arch/x86/um/../kernel/module.c: In function 'apply_relocate_add':
>> arch/x86/um/../kernel/module.c:204:8: error: 'R_X86_64_PC64' undeclared (first use in this function); did you mean 'R_X86_64_PC16'?
      case R_X86_64_PC64:
           ^~~~~~~~~~~~~
           R_X86_64_PC16
   arch/x86/um/../kernel/module.c:204:8: note: each undeclared identifier is reported only once for each function it appears in

vim +204 arch/x86/um/../kernel/module.c

    99	
   100	#ifdef CONFIG_X86_32
   101	int apply_relocate(Elf32_Shdr *sechdrs,
   102			   const char *strtab,
   103			   unsigned int symindex,
   104			   unsigned int relsec,
   105			   struct module *me)
   106	{
   107		unsigned int i;
   108		Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
   109		Elf32_Sym *sym;
   110		uint32_t *location;
   111	
   112		DEBUGP("Applying relocate section %u to %u\n",
   113		       relsec, sechdrs[relsec].sh_info);
   114		for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
   115			/* This is where to make the change */
   116			location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
   117				+ rel[i].r_offset;
   118			/* This is the symbol it is referring to.  Note that all
   119			   undefined symbols have been resolved.  */
   120			sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
   121				+ ELF32_R_SYM(rel[i].r_info);
   122	
   123			switch (ELF32_R_TYPE(rel[i].r_info)) {
   124			case R_386_32:
   125				/* We add the value into the location given */
   126				*location += sym->st_value;
   127				break;
   128			case R_386_PC32:
   129				/* Add the value, subtract its position */
   130				*location += sym->st_value - (uint32_t)location;
   131				break;
   132			default:
   133				pr_err("%s: Unknown relocation: %u\n",
   134				       me->name, ELF32_R_TYPE(rel[i].r_info));
   135				return -ENOEXEC;
   136			}
   137		}
   138		return 0;
   139	}
   140	#else /*X86_64*/
   141	int apply_relocate_add(Elf64_Shdr *sechdrs,
   142			   const char *strtab,
   143			   unsigned int symindex,
   144			   unsigned int relsec,
   145			   struct module *me)
   146	{
   147		unsigned int i;
   148		Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
   149		Elf64_Sym *sym;
   150		void *loc;
   151		u64 val;
   152	
   153		DEBUGP("Applying relocate section %u to %u\n",
   154		       relsec, sechdrs[relsec].sh_info);
   155		for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
   156			/* This is where to make the change */
   157			loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
   158				+ rel[i].r_offset;
   159	
   160			/* This is the symbol it is referring to.  Note that all
   161			   undefined symbols have been resolved.  */
   162			sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
   163				+ ELF64_R_SYM(rel[i].r_info);
   164	
   165			DEBUGP("type %d st_value %Lx r_addend %Lx loc %Lx\n",
   166			       (int)ELF64_R_TYPE(rel[i].r_info),
   167			       sym->st_value, rel[i].r_addend, (u64)loc);
   168	
   169			val = sym->st_value + rel[i].r_addend;
   170	
   171			switch (ELF64_R_TYPE(rel[i].r_info)) {
   172			case R_X86_64_NONE:
   173				break;
   174			case R_X86_64_64:
   175				if (*(u64 *)loc != 0)
   176					goto invalid_relocation;
   177				*(u64 *)loc = val;
   178				break;
   179			case R_X86_64_32:
   180				if (*(u32 *)loc != 0)
   181					goto invalid_relocation;
   182				*(u32 *)loc = val;
   183				if (val != *(u32 *)loc)
   184					goto overflow;
   185				break;
   186			case R_X86_64_32S:
   187				if (*(s32 *)loc != 0)
   188					goto invalid_relocation;
   189				*(s32 *)loc = val;
   190				if ((s64)val != *(s32 *)loc)
   191					goto overflow;
   192				break;
   193			case R_X86_64_PC32:
   194			case R_X86_64_PLT32:
   195				if (*(u32 *)loc != 0)
   196					goto invalid_relocation;
   197				val -= (u64)loc;
   198				*(u32 *)loc = val;
   199	#if 0
   200				if ((s64)val != *(s32 *)loc)
   201					goto overflow;
   202	#endif
   203				break;
 > 204			case R_X86_64_PC64:
   205				if (*(u64 *)loc != 0)
   206					goto invalid_relocation;
   207				val -= (u64)loc;
   208				*(u64 *)loc = val;
   209				break;
   210			default:
   211				pr_err("%s: Unknown rela relocation: %llu\n",
   212				       me->name, ELF64_R_TYPE(rel[i].r_info));
   213				return -ENOEXEC;
   214			}
   215		}
   216		return 0;
   217	
   218	invalid_relocation:
   219		pr_err("x86/modules: Skipping invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
   220		       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
   221		return -ENOEXEC;
   222	
   223	overflow:
   224		pr_err("overflow in relocation type %d val %Lx\n",
   225		       (int)ELF64_R_TYPE(rel[i].r_info), val);
   226		pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
   227		       me->name);
   228		return -ENOEXEC;
   229	}
   230	#endif
   231	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BOKacYhQ+x31HxR3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--BOKacYhQ+x31HxR3--
