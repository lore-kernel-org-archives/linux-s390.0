Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1916EB7A
	for <linux-s390@vger.kernel.org>; Thu,  1 Aug 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515340; cv=none; b=dYD4l/Hz4Hv0Hr/ay8M/UVsLsmjNQWSAxyngBezxCPpeGXFWKNmFkncJAMmlbB19eE2UtrQYnb5seA8sujFjLLYhkSEv/Wbp33yDiRG/4gejrci3rD+xZFg3rxUNf2Z+EPB/lSGDS9jAzsPUlltpRX7o6ONN6YO9dIu09wWMmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515340; c=relaxed/simple;
	bh=VfXADy/ySBfOCphPxL6hs+Oz5DZ0bp5cCMlkz16f9B4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HE1GsBPq+vTheuX+BysnBiceHjymTC5EGhuMpAzjP4xkxBPC9wP5WLo19WBjEuMU4q+03TSHGe7iM3vB2hE6OIfhmkLhHd/5W9Vs70G+RY9EULwB2G6O8h7qeY1aL3yzZOwpDeKx1Q+7Ap7PzQqStH7iCdRrw6oRMeoh4v/QHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ce4o/6Ol; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ce4o/6Ol"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471C05jh024884
	for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2024 12:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	IuGPYtF3cS+yYNgCF7TzR8glUmgmN8d6OwMoRHHo7Ho=; b=Ce4o/6OlX1azY4Fo
	r9cX9G5GNkh7btVZBS+G1lMHu7rKVBt0d1ePN2o4qEyvxC3LUY3tpx2vsGqA5CVf
	qunL19ORd9m8aLzX0KsfGjpH6uDMycDRfxSoGj1AidVnC2aBpwVKlcQnOdm97zzE
	GrX/hmhIl5oN1t2mFhUJgmWLtCB6uhMfQLYVFZ1o5SPv0ua2URJfUCVrcqN5yipL
	TDyqhu2zirQ1tqlvB47vbhL0qmMBsnVXnQg0xehbA5hKLAX+tI6qQn38JQ/lQgsU
	mo1Uz9vY8uUGIUKyhK3/oLZJyMfLzwRibiXWY7/I7dcMpgwWjn58txrXQzEkf0xb
	FtXDHQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r9yeg2xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2024 12:28:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471BqtN5018811
	for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2024 12:28:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q1nvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2024 12:28:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471CSo0N55378266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 12:28:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD9F820040;
	Thu,  1 Aug 2024 12:28:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32392006E;
	Thu,  1 Aug 2024 12:28:48 +0000 (GMT)
Received: from [9.155.199.134] (unknown [9.155.199.134])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 12:28:48 +0000 (GMT)
Message-ID: <d81729e3-3f58-406c-ad88-84686d6ce3d9@linux.ibm.com>
Date: Thu, 1 Aug 2024 14:28:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: fix validity interception issue when gisa is
 switched off
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, nrb@linux.ibm.com
References: <20240731113102.849562-1-mimu@linux.ibm.com>
 <a9413be8-1c8f-43a7-b60b-569750a620e7@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
In-Reply-To: <a9413be8-1c8f-43a7-b60b-569750a620e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wiSsGNHZ-E4OPsT1AbIDgFYsLuFlxxxD
X-Proofpoint-GUID: wiSsGNHZ-E4OPsT1AbIDgFYsLuFlxxxD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010080



On 31.07.24 14:24, Christian Borntraeger wrote:
> Am 31.07.24 um 13:31 schrieb Michael Mueller:
>> The following validity interception occures when the gisa usage has been
>> switched off either by using kernel parameter "kvm.use_gisa=0" or by
>> setting the related sysfs attribute to N (echo N >/sys/module/kvm/
>> parameters/use_gisa).
>>
>> The issue surfaces in the host kernel with the following kernel 
>> message as
>> soon a new kvm guest start has been attemted.
>>
>> kvm: unhandled validity intercept 0x1011
>> WARNING: CPU: 0 PID: 781237 at arch/s390/kvm/intercept.c:101 
>> kvm_handle_sie_intercept+0x42e/0x4d0 [kvm]
>> Modules linked in: vhost_net tap tun xt_CHECKSUM xt_MASQUERADE 
>> xt_conntrack ipt_REJECT xt_tcpudp nft_compat x_tables nf_nat_tftp 
>> nf_conntrack_tftp vfio_pci_core irqbypass vhost_vsock 
>> vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb kvm 
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc 
>> mlx5_ib ib_uverbs ib_core mlx5_core uvdevice s390_trng eadm_sch 
>> vfio_ccw zcrypt_cex4 mdev vfio_iommu_type1 vfio sch_fq_codel drm 
>> i2c_core loop drm_panel_orientation_quirks configfs nfnetlink lcs ctcm 
>> fsm dm_service_time ghash_s390 prng chacha_s390 libchacha aes_s390 
>> des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 
>> sha1_s390 sha_common dm_mirror dm_region_hash dm_log zfcp 
>> scsi_transport_fc scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey zcrypt 
>> dm_multipath rng_core autofs4 [last unloaded: vfio_pci]
>> CPU: 0 PID: 781237 Comm: CPU 0/KVM Not tainted 
>> 6.10.0-08682-gcad9f11498ea #6
>> Hardware name: IBM 3931 A01 701 (LPAR)
>> Krnl PSW : 0704c00180000000 000003d93deb0122 
>> (kvm_handle_sie_intercept+0x432/0x4d0 [kvm])
>>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> Krnl GPRS: 000003d900000027 000003d900000023 0000000000000028 
>> 000002cd00000000
>>             000002d063a00900 00000359c6daf708 00000000000bebb5 
>> 0000000000001eff
>>             000002cfd82e9000 000002cfd80bc000 0000000000001011 
>> 000003d93deda412
>>             000003ff8962df98 000003d93de77ce0 000003d93deb011e 
>> 00000359c6daf960
>> Krnl Code: 000003d93deb0112: c020fffe7259    larl    %r2,000003d93de7e5c4
>>             000003d93deb0118: c0e53fa8beac    brasl    
>> %r14,000003d9bd3c7e70
>>            #000003d93deb011e: af000000        mc    0,0
>>            >000003d93deb0122: a728ffea        lhi    %r2,-22
>>             000003d93deb0126: a7f4fe24        brc    15,000003d93deafd6e
>>             000003d93deb012a: 9101f0b0        tm    176(%r15),1
>>             000003d93deb012e: a774fe48        brc    7,000003d93deafdbe
>>             000003d93deb0132: 40a0f0ae        sth    %r10,174(%r15)
>> Call Trace:
>>   [<000003d93deb0122>] kvm_handle_sie_intercept+0x432/0x4d0 [kvm]
>> ([<000003d93deb011e>] kvm_handle_sie_intercept+0x42e/0x4d0 [kvm])
>>   [<000003d93deacc10>] vcpu_post_run+0x1d0/0x3b0 [kvm]
>>   [<000003d93deaceda>] __vcpu_run+0xea/0x2d0 [kvm]
>>   [<000003d93dead9da>] kvm_arch_vcpu_ioctl_run+0x16a/0x430 [kvm]
>>   [<000003d93de93ee0>] kvm_vcpu_ioctl+0x190/0x7c0 [kvm]
>>   [<000003d9bd728b4e>] vfs_ioctl+0x2e/0x70
>>   [<000003d9bd72a092>] __s390x_sys_ioctl+0xc2/0xd0
>>   [<000003d9be0e9222>] __do_syscall+0x1f2/0x2e0
>>   [<000003d9be0f9a90>] system_call+0x70/0x98
>> Last Breaking-Event-Address:
>>   [<000003d9bd3c7f58>] __warn_printk+0xe8/0xf0
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Closes: 
>> https://ibm-systems-z.slack.com/archives/C04BWBXSKEY/p1722280755665409
>> Fixes: fe0ef0030463 ("KVM: s390: sort out physical vs virtual pointers 
>> usage")
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> 
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 

Thanks.
