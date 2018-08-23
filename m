From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Thu, 23 Aug 2018 10:24:47 +0200
Message-ID: <20180823102447.05430368.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
        <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
        <8f3f3f41-a052-1975-69e2-49e1a662ecab@linux.ibm.com>
        <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38b87fc4-9344-70d8-4602-bf8e114769ef@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 Aug 2018 09:48:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> > Migration of AP devices is not supported by this patch series, so this 
> > should
> > not be an issue.  
> 
> Might not be a problem now, but could be later. As I said in a different
> reply, the CPU model in QEMU does not care about KVM.
> 
> I want the QEMU CPU model and the KVM interfaces to be clean and future
> proof. That's why my opinion is to handle PQAP(QCI) just like all the
> other "feature blocks" we already have.

+1 to that sentiment.

It's better to try to get this correct now than having to hack around
should we want to implement things in the future.
