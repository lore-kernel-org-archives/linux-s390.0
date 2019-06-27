Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr760097.outbound.protection.outlook.com ([40.107.76.97]:51342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfF0LSE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 07:18:04 -0400
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Subject: Re: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for
 NUMA
Date: Thu, 27 Jun 2019 11:17:58 +0000
Message-ID: <20190627111755.GJ7133@okra.localdomain>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
 <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
In-Reply-To: <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE70FA20B7464849A9C1EC473C6D4C0A@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hoan Tran OS <hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

On Jun 26 08:28, Linus Torvalds wrote:
> This is not a comment on the patch series itself, it is a comment on the =
emails.
>=20
> Your email is mis-configured and ends up all being marked as spam for
> me, because you go through the wrong smtp server (or maybe your smtp
> server itself is miconfigured)
>=20
> All your emails fail dmarc, because the "From" header is
> os.amperecomputing.com, but the DKIM signature is for
> amperemail.onmicrosoft.com.

It appears Microsoft enables DKIM by default, but does so using keys
advertised at *.onmicrosoft.com domains, and our IT folks didn't
initially notice this. We believe we've rectified the situation, so
please let us know if our emails (including this one) continue to be an
issue.

> End result: it wil all go into the spam box of anybody who checks DKIM.

Interestingly, *some* receiving mail servers (at least gmail.com) were
reporting DKIM/DMARC pass for emails sent directly from our domain
(though not those sent through a mailing list), which I believe allowed
our IT to falsely think they had everything configured correctly.

-Aaron
