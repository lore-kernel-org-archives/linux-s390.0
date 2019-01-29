From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 10/13] KVM: s390: add kvm reference to struct
 sie_page2
Date: Tue, 29 Jan 2019 13:27:01 +0100
Message-ID: <20190129132701.563109e5@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-11-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-11-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:36 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Adding the kvm reference to struct sie_page2 will allow to
> determine the kvm a given gisa belongs to:
> 
>   container_of(gisa, struct sie_page2, gisa)->kvm
> 
> This functionality will be required to process a gisa in
> gib alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
