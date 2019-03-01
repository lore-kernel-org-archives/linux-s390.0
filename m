Return-Path: <SRS0=/L37=RE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v4 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190228063604.15298-1-alex@ghiti.fr>
 <20190228063604.15298-5-alex@ghiti.fr>
 <9a385cc8-581c-55cf-4a85-10b5c4dd178c@intel.com>
 <31212559-d397-88fb-eaec-60f6417436c8@oracle.com>
 <6c842251-1bed-4d79-bf6d-997006ec72e2@intel.com>
 <6ea4119a-0ecb-511d-3aab-269004245a08@oracle.com>
 <1cfaca88-a219-d057-3ab8-37fb1c1687d6@ghiti.fr>
 <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
 <027de1e2-a9cd-8ba7-859b-ee803937340a@suse.cz>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <4bff265e-e03c-6d74-c09f-a89b74009feb@ghiti.fr>
Date: Fri, 1 Mar 2019 14:58:49 +0100
MIME-Version: 1.0
In-Reply-To: <027de1e2-a9cd-8ba7-859b-ee803937340a@suse.cz>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Vlastimil Babka <vbabka@suse.cz>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On 03/01/2019 02:33 PM, Vlastimil Babka wrote:
> On 3/1/19 2:21 PM, Alexandre Ghiti wrote:
>> I collected mistakes here: domain name expired and no mailing list added :)
>> Really sorry about that, I missed the whole discussion (if any).
>> Could someone forward it to me (if any) ? Thanks !
> Bounced you David and Mike's discussion (4 messages total). AFAICS that
> was all.

Thank you Vlastimil, I got them.

Thanks,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
