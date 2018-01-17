From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH 2/6] s390: implement nospec_[load|ptr]
Date: Wed, 17 Jan 2018 09:52:09 -0500
Message-ID: <e269adc3-35ba-3ac9-1302-9211374f2d34@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
 <nycvar.YFH.7.76.1801171340460.11852@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1801171340460.11852@cbobk.fhfr.pm>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcus Meissner <meissner@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 01/17/2018 07:41 AM, Jiri Kosina wrote:
> On Wed, 17 Jan 2018, Martin Schwidefsky wrote:
> 
>> Implement nospec_load() and nospec_ptr() for s390 with the new
>> gmb() barrier between the boundary condition and the load that
>> may not be done speculatively.

Thanks for the patches, Martin et al. I tested various earlier versions
and will run these latest ones through some tests and add a tested by.

> FWIW the naming seems to be changing constantly. The latest patchset from 
> Dan Williams [1] uses ifence_...().
> 
> [1] lkml.kernel.org/r/151586744180.5820.13215059696964205856.stgit@dwillia2-desk3.amr.corp.intel.com

This is getting a little silly. Not to bikeshed this to death, but
obviously gmb (what was that ever supposed to stand for, global?) was
the wrong name. We favored seb (speculative execution barrier), etc.
Still, "ifence"? What is that supposed to mean? That sounds very
architecture specific vs. what we're actually trying to ensure, which is
that we don't speculatively load a pointer.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
