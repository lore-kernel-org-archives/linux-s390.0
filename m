From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Fri, 20 Apr 2018 14:15:47 +0200
Message-ID: <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3eMqAE81vonGJFht6nNny6RbI9K2v3NPb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb
Content-Type: multipart/mixed; boundary="nTdTieXVKijukp1sK58IHlWQMAQqhisVQ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
 pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
Message-ID: <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
In-Reply-To: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>

--nTdTieXVKijukp1sK58IHlWQMAQqhisVQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.04.2018 13:59, Janosch Frank wrote:
> Thanks, applied.
>=20

Well this does not compile, as you use kvm_s390_vcpu_crypto_setup before
declaration. Please fix, then I'll take the patch.


>=20
> On 19.04.2018 23:13, Tony Krowiak wrote:
>> Introduces a new function to reset the crypto attributes for all
>> vcpus whether they are running or not. Each vcpu in KVM will
>> be removed from SIE prior to resetting the crypto attributes in its
>> SIE state description. After all vcpus have had their crypto attribute=
s
>> reset the vcpus will be restored to SIE.
>>
>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>> function to fix a reported issue whereby the crypto key wrapping
>> attributes could potentially get out of synch for running vcpus.
>>
>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>>  2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index fa355a6..4fa3037 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
>>  	return ret;
>>  }
>>
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>> + {
>> +	int i;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>> +	        kvm_s390_vcpu_crypto_setup(vcpu);
>> +
>> +	kvm_s390_vcpu_unblock_all(kvm);
>> +}
>> +
>>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>>
>>  static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_=
attr *attr)
>> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm=
, struct kvm_device_attr *attr)
>>  		return -ENXIO;
>>  	}
>>
>> -	kvm_for_each_vcpu(i, vcpu, kvm) {
>> -		kvm_s390_vcpu_crypto_setup(vcpu);
>> -		exit_sie(vcpu);
>> -	}
>> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>>  	mutex_unlock(&kvm->lock);
>>  	return 0;
>>  }
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index 1b5621f..981e3ba 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>>  }
>>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>>  				     struct mcck_volatile_info *mcck_info);
>> +
>> +/**
>> + * kvm_s390_vcpu_crypto_reset_all
>> + *
>> + * Reset the crypto attributes for each vcpu. This can be done while =
the vcpus
>> + * are running as each vcpu will be removed from SIE before resetting=
 the crypt
>> + * attributes and restored to SIE afterward.
>> + *
>> + * Note: The kvm->lock must be held while calling this function
>> + *
>> + * @kvm: the KVM guest
>> + */
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>>  #endif
>>
>=20
>=20



--nTdTieXVKijukp1sK58IHlWQMAQqhisVQ--

--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa2dnzAAoJEBcO/8Q8ZEV5eLgP/2VWIvPhb9PlLBNNLTiZw9M6
IGScDIjRkHSwZA6YDeA+yaeQWJEFJnpt6NIa29d4O70tdGRV2zgPRIz2PdXeB0CR
8GaWmGipc7CbyS/lCKcatCssJqCpnaS+oc1+t/Lub2W7Dy1nvGNMXkXzVBx7wb/5
VDbZINzAkMdi8PIg1Zo5LvkkzotBkbQKYz0ywgmKVNo4ZD9AbQgDF3srf3YOkNGm
TzEuockYbgEia/p4bzRtRdt5vWCsFEMtoA/r3ZxRZn/6YfoqiuapNAwymH67DSvg
8sK2qqxzyZthGAbuY2xBDBVFIHB3nxiHpE1J3zsdICIIlDgif9yr9b56KNszn2vk
wJ//rMhDI+Y7az00CMxAoQv1gFQnpkkDa0eGor24dqkzvITXMmbBR4fFwWRuVHkA
oyzlGfUvOJsmFNwwYaJKahzLzyOwBkoY1DR5rZldn5niJPi2MmABvg4XGIoq+ZSC
hFTH0P4GNRDY8IX6lZ1LsxSDkjFFed+W2PBLqLdnJ4IeHs+JWpS5ydXcv3L5hEvo
kOEQJp4mKgXTBk+S71zRMFymCZOd/O5WuvyybYgl1npMp2+x9h4Geazanhq474uk
OWoIuXylKbh/0myav+NcPOhmpyak03+4pEmLeyMi+im/tjmdmqWIkY5LdApbRrb1
FbvAxj9Ee4bvgqnS7jxE
=97Ch
-----END PGP SIGNATURE-----

--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb--
