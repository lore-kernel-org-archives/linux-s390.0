From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Date: Wed, 28 Mar 2018 21:07:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
 <20180328000025.GM1436@brightrain.aerifal.cx>
In-Reply-To: <20180328000025.GM1436@brightrain.aerifal.cx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <tony.luck@intel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Rich Felker <dalias@libc.org>, Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Ilya Smith <blackzert@gmail.com>, Michal Hocko <mhocko@kernel.org>, Richard Henderson <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, "Yu, Fenghua" <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, "nyc@holomorphy.com" <nyc@holomorphy.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Hugh Dickins <hughd@google.com>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Nick Piggin <npiggin@gmail.com>, Bhupesh Sharma <bhsharma@redhat.com>, Rik van Riel <riel@redhat.com>, "nitin.m.gupta@oracle.com" <nitin.m.gupta@oracle.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, Ross Zwisler <ross.zwisler@linux.intel.com>, Jerome Glisse <jglisse@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Oleg Nesterov <oleg@redhat.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-parisc <linux-parisc@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-s390.vger.kernel.org>

> The default limit of only 65536 VMAs will also quickly come into play
> if consecutive anon mmaps don't get merged. Of course this can be
> raised, but it has significant resource and performance (fork) costs.

Could the random mmap address chooser look for how many existing
VMAs have space before/after and the right attributes to merge with the
new one you want to create? If this is above some threshold (100?) then
pick one of them randomly and allocate the new address so that it will
merge from below/above with an existing one.

That should still give you a very high degree of randomness, but prevent
out of control numbers of VMAs from being created.

-Tony
