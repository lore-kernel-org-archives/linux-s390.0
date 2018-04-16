From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 13/15] KVM: s390: configure the guest's AP devices
Date: Mon, 16 Apr 2018 16:51:31 +0200
Message-ID: <a233848d-9f71-75bc-b720-66d9a54f8185@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2e7387b9-ceb4-cdca-56ac-f5344084e10a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e7387b9-ceb4-cdca-56ac-f5344084e10a@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/16/2018 03:05 PM, Pierre Morel wrote:
>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +    kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
>> +    kvm_ap_interpret_instructions(matrix_mdev->kvm, false);
> 
> This call clears the apie in KVM.
> This is only OK if we have a single device present until the end of the VM,
> otherwise AP instructions in the guest will fail after the release until the end of the VM
> or until a new device is plugged.

I agree, this seems wrong.
