From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Date: Wed, 22 Aug 2018 12:09:39 +0200
Message-ID: <20180822120939.0e08e68b.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180820180359.38cc4af3.cohuck@redhat.com>
        <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
        <20180821175309.55b774ca.cohuck@redhat.com>
        <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 22 Aug 2018 09:04:13 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> Well, sooner or later this has to work. Yesterday we tested the control
> domain thing with trying to pull some simple data from a 'controlled' domain
> to the TKE - doesn't work with a Linux LPAR. I will investigate the details in the
> next weeks. However, long-term it should be possible to run scenarios
> like having one KVM guest control all the domains used by other KVM guests.
> With respect to the KVM vfio driver, currently there should be just the
> rule that for a guest the control domain mask should be equal or a superset
> of the usage domain mask. This is by convention as the architecture is
> not so clear here, but this is enforced on every place which deals with
> usage and control domains (SE, TKE).

Thanks for the update; this makes me think we really should fiddle with
the masks in the kernel (as opposed to doing it higher up in the stack).
