Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Mar 2018 15:42:18 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 09/11] kexec_file: Remove mis-use of sh_offset field
Message-ID: <20180312074218.GA4125@dhcp-128-65.nay.redhat.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
 <20180226151620.20970-10-prudo@linux.vnet.ibm.com>
 <20180309031420.GA3246@dhcp-128-65.nay.redhat.com>
 <20180309110241.00b0d3f3@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309110241.00b0d3f3@ThinkPad>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Philipp,
On 03/09/18 at 11:02am, Philipp Rudo wrote:
> Hi Dave,
> 
> 
> On Fri, 9 Mar 2018 11:14:20 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 02/26/18 at 04:16pm, Philipp Rudo wrote:
> > > The current code uses the sh_offset field in purgatory_info->sechdrs to
> > > store a pointer to the current load address of the section. Depending
> > > whether the section will be loaded or not this is either a pointer into
> > > purgatory_info->purgatory_buf or kexec_purgatory. This is not only a
> > > violation of the ELF standard but also makes the code very hard to
> > > understand as you cannot tell if the memory you are using is read-only or
> > > not.
> > > 
> > > Remove this mis-use and store the offset of the section in
> > > pugaroty_info->purgatory_buf in sh_offset.
> > > 
> > > Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > > ---
> > >  arch/x86/kernel/machine_kexec_64.c | 10 ++++++----
> > >  kernel/kexec_file.c                | 33 +++------------------------------
> > >  2 files changed, 9 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > index 51667c8b5c9b..41db74bdc88b 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -457,13 +457,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> > >  		 * rel[i].r_offset contains byte offset from beginning
> > >  		 * of section to the storage unit affected.
> > >  		 *
> > > -		 * This is location to update (->sh_offset). This is temporary
> > > -		 * buffer where section is currently loaded. This will finally
> > > -		 * be loaded to a different address later, pointed to by
> > > +		 * This is location to update. This is temporary buffer
> > > +		 * where section is currently loaded. This will finally be
> > > +		 * loaded to a different address later, pointed to by
> > >  		 * ->sh_addr. kexec takes care of moving it
> > >  		 *  (kexec_load_segment()).
> > >  		 */
> > > -		location = (void *)(section->sh_offset + rel[i].r_offset);
> > > +		location = pi->purgatory_buf;
> > > +		location += section->sh_offset;
> > > +		location += rel[i].r_offset;
> > >  
> > >  		/* Final address of the location */
> > >  		address = section->sh_addr + rel[i].r_offset;
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 746b91e46e34..25b44d1a664a 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -736,28 +736,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> > >  	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
> > >  	pi->sechdrs = sechdrs;
> > >  
> > > -	/*
> > > -	 * We seem to have multiple copies of sections. First copy is which
> > > -	 * is embedded in kernel in read only section. Some of these sections
> > > -	 * will be copied to a temporary buffer and relocated. And these
> > > -	 * sections will finally be copied to their final destination at
> > > -	 * segment load time.  
> > 
> > It would be good to keep above part comment somewhere..
> 
> there is a comment in include/linux/kexec.h for the purgatory_info->sechdrs
> field saying 
> 
> Temporary, modifiable buffer for sechdrs used for relocation.        
> This memory can be freed post image load
> 
> When you think this is not enough i can add a comment here like
> 
> The section headers in kexec_purgatory are read-only. In order to have them
> modifiable make a temporary copy.

Looks better to add above comment here.

> 
> What do you think.
> 
> Thanks
> Philipp
> 
> > > -	 *
> > > -	 * Use ->sh_offset to reflect section address in memory. It will
> > > -	 * point to original read only copy if section is not allocatable.
> > > -	 * Otherwise it will point to temporary copy which will be relocated.
> > > -	 *
> > > -	 * Use ->sh_addr to contain final address of the section where it
> > > -	 * will go during execution time.
> > > -	 */
> > > -	for (i = 0; i < pi->ehdr->e_shnum; i++) {
> > > -		if (sechdrs[i].sh_type == SHT_NOBITS)
> > > -			continue;
> > > -
> > > -		sechdrs[i].sh_offset = (unsigned long)pi->ehdr +
> > > -						sechdrs[i].sh_offset;
> > > -	}
> > > -
> > >  	offset = 0;
> > >  	bss_addr = kbuf->mem + kbuf->bufsz;
> > >  	kbuf->image->start = pi->ehdr->e_entry;
> > > @@ -786,17 +764,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> > >  			kbuf->image->start += kbuf->mem + offset;
> > >  		}
> > >  
> > > -		src = (void *)sechdrs[i].sh_offset;
> > > +		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
> > >  		dst = pi->purgatory_buf + offset;
> > >  		memcpy(dst, src, sechdrs[i].sh_size);
> > >  
> > >  		sechdrs[i].sh_addr = kbuf->mem + offset;
> > > -
> > > -		/*
> > > -		 * This section got copied to temporary buffer. Update
> > > -		 * ->sh_offset accordingly.
> > > -		 */
> > > -		sechdrs[i].sh_offset = (unsigned long)dst;
> > > +		sechdrs[i].sh_offset = offset;
> > >  		offset += sechdrs[i].sh_size;
> > >  	}
> > >  
> > > @@ -1006,7 +979,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	sym_buf = (char *)sec->sh_offset + sym->st_value;
> > > +	sym_buf = (char *)pi->purgatory_buf + sec->sh_offset + sym->st_value;
> > >  
> > >  	if (get_value)
> > >  		memcpy((void *)buf, sym_buf, size);
> > > -- 
> > > 2.13.5
> > >   
> > 
> > Thanks
> > Dave
> > 
> 

Thanks
Dave
