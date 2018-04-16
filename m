From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive
 execution
Date: Mon, 16 Apr 2018 13:12:48 +0200
Message-ID: <dbd7a1fa-a5c4-a931-5606-e9e2301589f2@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/15/2018 11:22 PM, Tony Krowiak wrote:
> The VFIO AP device model exploits interpretive execution of AP
> instructions (APIE) to provide guests passthrough access to AP
> devices. This patch introduces a new interface to enable and
> disable APIE.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

LGTM, but should be squashed into #4. (Like this you have a
kernel that supports the cpu model feature 'ap' but does not
do 'interpretation is default'.) 
