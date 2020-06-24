Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 24 Jun 2020 13:05:39 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
Message-ID: <20200624110539.GC24934@oc3871087118.ibm.com>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, christophe.leroy@c-s.fr, ziy@nvidia.com, gerald.schaefer@de.ibm.com, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>

On Wed, Jun 24, 2020 at 08:43:10AM +0530, Anshuman Khandual wrote:

[...]

> Hello Gerald/Christophe/Vineet,
> 
> It would be really great if you could give this series a quick test
> on s390/ppc/arc platforms respectively. Thank you.

That worked for me with the default and debug s390 configurations.
Would you like to try with some particular options or combinations
of the options?

> - Anshuman
