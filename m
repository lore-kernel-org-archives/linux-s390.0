From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 13/13] KVM: s390: start using the GIB
Date: Tue, 29 Jan 2019 14:27:56 +0100
Message-ID: <20190129142756.015772d5@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-14-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-14-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:39 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> By initializing the GIB, it will be used by the kvm host.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
