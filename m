Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:45904 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZA2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jun 2019 20:28:42 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so1080000ioc.12
        for <linux-s390@vger.kernel.org>; Tue, 25 Jun 2019 17:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jun 2019 08:28:30 +0800
Message-ID: <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hoan Tran OS <hoan@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Mike Rapoport <rppt@linux.ibm.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Open Source Submission <patches@amperecomputing.com>

This is not a comment on the patch series itself, it is a comment on the emails.

Your email is mis-configured and ends up all being marked as spam for
me, because you go through the wrong smtp server (or maybe your smtp
server itself is miconfigured)

All your emails fail dmarc, because the "From" header is
os.amperecomputing.com, but the DKIM signature is for
amperemail.onmicrosoft.com.

End result: it wil all go into the spam box of anybody who checks DKIM.

                       Linus

On Wed, Jun 26, 2019 at 6:30 AM Hoan Tran OS
<hoan@os.amperecomputing.com> wrote:
>
> This patch set enables CONFIG_NODES_SPAN_OTHER_NODES by default
> for NUMA. [...]
