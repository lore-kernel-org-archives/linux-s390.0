Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgKCP4v (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Nov 2020 10:56:51 -0500
Date: Tue, 3 Nov 2020 17:56:36 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 2/4] PM: hibernate: make direct map manipulations more
 explicit
Message-ID: <20201103155636.GJ4879@kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <20201103110816.t6a3ebtgcm7mfogy@box>
 <20201103121350.GI4879@kernel.org>
 <20201103143916.otz2o4h2dlmewn3h@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103143916.otz2o4h2dlmewn3h@box>
List-ID: <linux-s390.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Len Brown <len.brown@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 03, 2020 at 05:39:16PM +0300, Kirill A. Shutemov wrote:
> On Tue, Nov 03, 2020 at 02:13:50PM +0200, Mike Rapoport wrote:
> > > > +
> > > > +		if (WARN_ON(ret))
> > > 
> > > _ONCE?
> > 
> > I've changed it to pr_warn() after David said people enable panic on
> > warn in production kernels.
> 
> pr_warn_once()? :P

Sure :)

-- 
Sincerely yours,
Mike.
