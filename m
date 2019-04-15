Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 15 Apr 2019 20:59:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource
 in use
In-Reply-To: <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
        <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
        <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
        <20190412114313.0156c01b.cohuck@redhat.com>
        <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
        <20190415115030.1df61182.cohuck@redhat.com>
        <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190415205950.7655cee3@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2019 12:51:23 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Having said that, I understand your concern about a driver hogging
> resources. I think I can provide a solution that serves both the
> purpose of preventing problems associated with accidental removal
> of AP resources as well as allowing root to remove them
> forcefully. I'll work on that for v2.

Can you tell us some more about this solution? Should we stop reviewing
v1 because v2 is going to be different anyway?

Regards,
Halil
