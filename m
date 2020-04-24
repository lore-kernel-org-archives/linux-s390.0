Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Apr 2020 08:43:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
Message-ID: <20200424134301.rug4i5hxtnplahge@treble>
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004221411140.28581@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004221411140.28581@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com

On Wed, Apr 22, 2020 at 02:28:26PM +0200, Miroslav Benes wrote:
> > +int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> > +		       unsigned int symindex, unsigned int relsec,
> > +		       struct module *me)
> > +{
> > +	int ret;
> > +	bool early = me->state == MODULE_STATE_UNFORMED;
> > +	void *(*write)(void *, const void *, size_t) = memcpy;
> > +
> > +	if (!early) {
> > +		write = s390_kernel_write;
> > +		mutex_lock(&text_mutex);
> > +	}
> > +
> > +	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
> > +				   write);
> > +
> > +	if (!early)
> > +		mutex_unlock(&text_mutex);
> > +
> > +	return ret;
> > +}
> 
> It means that you can take text_mutex the second time here because it 
> is still taken in klp_init_object_loaded(). It is removed later in the 
> series though. The same applies for x86 patch.
> 
> Also, s390_kernel_write() grabs s390_kernel_write_lock spinlock before 
> writing anything, so maybe text_mutex is not really needed as long as 
> s390_kernel_write is called everywhere for text patching.

Good catch, maybe I'll just drop the text_mutex here.

-- 
Josh
