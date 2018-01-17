From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/6] s390: implement nospec_[load|ptr]
Date: Wed, 17 Jan 2018 13:41:54 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801171340460.11852@cbobk.fhfr.pm>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com> <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018, Martin Schwidefsky wrote:

> Implement nospec_load() and nospec_ptr() for s390 with the new
> gmb() barrier between the boundary condition and the load that
> may not be done speculatively.

FWIW the naming seems to be changing constantly. The latest patchset from 
Dan Williams [1] uses ifence_...().

[1] lkml.kernel.org/r/151586744180.5820.13215059696964205856.stgit@dwillia2-desk3.amr.corp.intel.com

-- 
Jiri Kosina
SUSE Labs
