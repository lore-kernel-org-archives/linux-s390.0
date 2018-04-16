From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 15/15] s390: doc: detailed specifications for AP
 virtualization
Date: Mon, 16 Apr 2018 15:53:53 +0200
Message-ID: <20180416155353.01bee181.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
        <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Apr 2018 15:13:59 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 15/04/2018 23:22, Tony Krowiak wrote:

> > +* Register with the ap_bus for AP queue devices of type CEX4, CEX5 and
> > +  CEX6 and to provide the vfio_ap driver's probe and remove callback interfaces.  
> 
> I wonder why the type of card has anything to do with this driver.
> It should be transparent, the driver should be able to provide the 
> matrix (APM/AQM/ADM)
> independently from the type of card in the slot.

Would also be interested why this is limited to certain, newer cards.
Did some kind of interface change (I dimly recall something like that),
or are simply no old systems with those older card types around to check
whether it works?

In either case, a short note would be good (does not need to go into
any details).
