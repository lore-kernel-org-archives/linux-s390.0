From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 05/19] s390/zcrypt: base implementation of AP matrix
 device driver
Date: Mon, 20 Nov 2017 18:15:49 +0100
Message-ID: <20171120181549.354ed0c4.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20171114134040.3fcd6efd.cohuck@redhat.com>
        <06ddee4e-e1b8-ba17-5e3e-241e4dcf7cd0@linux.vnet.ibm.com>
        <c9ec3c2e-bbc5-a08e-acea-0a3030bc90a7@linux.vnet.ibm.com>
        <20171116133531.1135a093.cohuck@redhat.com>
        <f1def4fc-49d8-8662-208b-fcea22ee87b0@linux.vnet.ibm.com>
        <20171116174741.18e3f40b.cohuck@redhat.com>
        <f93f8ef5-b568-20ad-3e61-2e95193e362c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f93f8ef5-b568-20ad-3e61-2e95193e362c@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Nov 2017 16:13:45 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 11/16/2017 11:47 AM, Cornelia Huck wrote:

> > [Also, is IOMMU_API only needed to satisfy dependencies?]  
> Yes, VFIO is dependent upon it.

Ah, my question was more whether we just need to make sure the api is
there, but do not need to implement anything.
