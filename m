From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 03/15] KVM: s390: move bitmap idle_mask into arch
 struct top level
Date: Thu, 31 Jan 2019 13:19:41 +0100
Message-ID: <20190131131941.7647e20d@oc2783563651>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
        <20190131085247.13826-4-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-4-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Jan 2019 09:52:34 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The vcpu idle_mask state is used by but not specific
> to the emulated floating interruptions. The state is
> relevant to gisa related interruptions as well.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>
