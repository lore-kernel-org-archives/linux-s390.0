From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 06/13] KVM: s390: remove kvm_s390_ from gisa static
 inline functions
Date: Mon, 28 Jan 2019 16:55:29 +0100
Message-ID: <20190128165529.65d4d6ab@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-7-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-7-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:32 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Tags: inv, patch, s390 
> From: Michael Mueller <mimu@linux.ibm.com>
> To: KVM Mailing List <kvm@vger.kernel.org>
> Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
> Subject: [PATCH v6 06/13] KVM: s390: remove kvm_s390_ from gisa static inline functions
> Date: Thu, 24 Jan 2019 13:59:32 +0100
> X-Mailer: git-send-email 2.13.4
> 
> This will shorten the length of code lines. All GISA related
> static inline functions are local to interrupt.c.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
