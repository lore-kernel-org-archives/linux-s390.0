From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/8] s390: I/O interrupt and machine check injection.
Date: Tue, 11 Dec 2012 13:50:10 +0100
Message-ID: <20121211135010.36872984@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-4-git-send-email-cornelia.huck@de.ibm.com>
	<82610216-94CA-44E8-B3CE-EB94886CECFC@suse.de>
	<20121210112726.0697bc4f@BR9GNB5Z>
	<7338881F-11E8-4C21-BB81-E02F65DDB73D@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7338881F-11E8-4C21-BB81-E02F65DDB73D@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Dec 2012 11:29:16 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 10.12.2012, at 11:27, Cornelia Huck wrote:
> 
> > On Mon, 10 Dec 2012 09:20:57 +0100
> > Alexander Graf <agraf@suse.de> wrote:
> > 
> >> 
> >> On 07.12.2012, at 13:50, Cornelia Huck wrote:

> >>> +        /* CRW machine checks disabled */
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
> >> 
> >> Check missing again.
> > 
> > Perhaps we want {map,unmap}_lowcore() functions?
> 
> Awesome idea!

I'll cook up an extra patch for this then (and make the ext stuff use
it).
