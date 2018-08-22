From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
Date: Wed, 22 Aug 2018 12:45:14 +0200
Message-ID: <b80ae83f-0339-0eea-e12b-d5b21e6138fd@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820180359.38cc4af3.cohuck@redhat.com>
 <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
 <20180821175309.55b774ca.cohuck@redhat.com>
 <63e80d08-3176-726e-b2ef-826547ac97a9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63e80d08-3176-726e-b2ef-826547ac97a9@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/22/2018 12:13 PM, Harald Freudenberger wrote:
> ... about control domains
> 
> Talked with the s390 firmware guys. The convention that the control domain
> mask is a superset of the usage domain mask is only true for 1st level guests.
> 
> It is absolutely valid to run a kvm guest with restricted control domain
> mask bitmap in the CRYCB. It is valid to have an empty control domain mask
> and the guest should be able to run crypto CPRBs on the usage domain(s) without
> any problems. However, nobody has tried this.

I did try this ;).

> 
> regards
> Harald Freudenberger
> 
> 
