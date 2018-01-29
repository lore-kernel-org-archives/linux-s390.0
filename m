From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Mon, 29 Jan 2018 20:12:31 +0000
Message-ID: <20180129201231.4ebec569@alans-desktop>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
        <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
        <20180123170719.GA4154@isilmar-4.linta.de>
        <20180124072953.50851fec@mschwideX1>
        <20180124083705.GA14868@light.dominikbrodowski.net>
        <20180124111552.GA24675@amd>
        <20180124134803.3e11c6d6@mschwideX1>
        <20180124190105.GA30107@amd>
        <20180124204622.1f7b0de2@alans-desktop>
        <20180129131446.GB4669@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180129131446.GB4669@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 29 Jan 2018 14:14:46 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-01-24 20:46:22, Alan Cox wrote:
> > > Anyway, no need to add prctl(), if A can ptrace B and B can ptrace A,
> > > leaking info between them should not be a big deal. You can probably
> > > find existing macros doing neccessary checks.  
> > 
> > Until one of them is security managed so it shouldn't be able to ptrace
> > the other, or (and this is the nasty one) when a process is executing
> > code it wants to protect from the rest of the same process (eg an
> > untrusted jvm, javascript or probably nastiest of all webassembly)
> > 
> > We don't need a prctl for trusted/untrusted IMHO but we do eventually
> > need to think about API's for "this lot is me but I don't trust
> > it" (flatpack, docker, etc) and for what JIT engines need to do.  
> 
> Agreed.
> 
> And yes, JITs are interesting, and given the latest
> rowhammer/sidechannel attacks, something we may want to limit in
> future...
> 
> It sounds nice on paper but is just risky.

I don't think java, javascript, webassembly, (and for some
implementations truetype, pdf, postscript, ... and more) are going away
in a hurry.

Alan
