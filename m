Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 May 2020 16:33:01 +0200
From: Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200505143300.GA14113@oc3748833570.ibm.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
 <20200505135556.GA9920@oc3748833570.ibm.com>
 <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
 <d1de4fb2-dfe6-83fa-9973-2505d4c397ec@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1de4fb2-dfe6-83fa-9973-2505d4c397ec@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On Tue, May 05, 2020 at 04:03:00PM +0200, Christian Borntraeger wrote:
> > Just looked at 
> > commit 88b1a17dfc3ed7728316478fae0f5ad508f50397  mm: add 'try_get_page()' helper function
> > 
> > which says:
> >     Also like 'get_page()', you can't use this function unless you already
> >     had a reference to the page.  The intent is that you can use this
> >     exactly like get_page(), but in situations where you want to limit the
> >     maximum reference count.
> >     
> >     The code currently does an unconditional WARN_ON_ONCE() if we ever hit
> >     the reference count issues (either zero or negative), as a notification
> >     that the conditional non-increment actually happened.
> > 
> > If try_get_page must not be called with an existing reference, that means
> 		s/not//
> > that when we call it the page reference is already higher and our freeze
> > will never succeed. That would imply that we cannot trigger this. No?

Well, my understanding is that the "existing" reference may be one of the
references that is expected by our freeze code, in particular in gup the
existing reference is simply the one from the pte.  So in this case our
freeze *would* succeeed.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
