From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 09/17] target-s390x: Define S390 CPU
 model specific facility lists
Date: Mon, 27 Apr 2015 10:59:26 +0200
Message-ID: <20150427105926.3aec0c8f@bee>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1428933396-37887-10-git-send-email-mimu@linux.vnet.ibm.com>
	<553DEF3C.7080408@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553DEF3C.7080408@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 Apr 2015 10:11:40 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 13.04.2015 um 15:56 schrieb Michael Mueller:
> > --- a/target-s390x/cpu-models.c
> > +++ b/target-s390x/cpu-models.c
> 
> > @@ -76,3 +87,4 @@ S390_PROC_DEF("2827-ga1", CPU_S390_2827_GA1, "IBM zEnterprise EC12 GA1")
> >  S390_PROC_DEF("2827-ga2", CPU_S390_2827_GA2, "IBM zEnterprise EC12 GA2")
> >  S390_PROC_DEF("2828-ga1", CPU_S390_2828_GA1, "IBM zEnterprise BC12 GA1")
> >  S390_PROC_DEF("2964-ga1", CPU_S390_2964_GA1, "IBM z13 GA1")
> > +
> 
> Blank line at end of file, git am also complains:
> 
> Applying: target-s390x: Define S390 CPU model specific facility lists
> /home/cborntra/REPOS/qemu/.git/rebase-apply/patch:54: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

I will address this here and in the next patch, checkpatch does not seem to catch that.
