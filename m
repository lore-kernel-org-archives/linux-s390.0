Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB5282F3B;
	Thu, 28 May 2026 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976369; cv=none; b=BG5zfIpdh39D9/VgFxN9w4c4ZF2O0viHAI7I2jAnUrbHXvJDkjexxmIBvrl2rZD6ct0D+bBh4ytqo3BP680OeaGbrRO4zkt8DjgXdZ6b2jRivm2eds9AkFaD8LHR64NdgFdAChLsB2BiCokcmPRqxe5DY2JNW0Bj4AlzZjl7iSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976369; c=relaxed/simple;
	bh=zhvSnNGUh2IRJp5nVbZsmG1LkcO75ndEjlUvsA3/908=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RLPzyjnSkTWr58akh6YsgECEmCqYruWODw8S7/CSye/FhMgfmU+8OC47XbkjL1aP5f1lW6mffTTgrKofz3zSDxN8LJdXwUUkeqN4/14/m1IWVh1tMvEQRyBv3YuY8cVjFFyzxqGmLj3HWfp2+rf6t4/bQVZguodCqhGELjP4DE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WvUmbyju; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WvUmbyju"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SD1oZR3427017;
	Thu, 28 May 2026 13:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5/jjn+
	SPcc4N10kKApuI8lm+1OeKOU74VHx3XKWgGyE=; b=WvUmbyju20Q3NUpCPZ20Yn
	r2jFzJztRpuIVJWr37qlujmyTSkVFV+cshDeI5eTQu34QlorOHh2MZ/lBU152teV
	9n4/RfaLqeU9/9VljfSkp82ASyeFMku90Hnjedl0PRCguAgyJ78ppMNEix6m7BNj
	JW17yw7Rhgma/Tma00q76WgrJZIZdcQa+6WaAadoiTjtakbxBC4NBSqyOG8WcQxp
	MTaGAhYd+IrkhMEL9Xg6AIDEh+KzHJ5PirTikTsucUIXH0ZnVa0q5U54WitDc0fh
	C9hW+eHpe8YuEcVS1szw7jIbVgmAYLq0S++SbgsVvvlCTYMm5huW+vjKUJbyYS0A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884kaqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 13:52:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDgfCQ006541;
	Thu, 28 May 2026 13:52:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0amj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 13:52:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SDqhQ835979894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 13:52:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63F515805B;
	Thu, 28 May 2026 13:52:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3603058058;
	Thu, 28 May 2026 13:52:42 +0000 (GMT)
Received: from [9.61.144.185] (unknown [9.61.144.185])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 13:52:42 +0000 (GMT)
Message-ID: <7891b20d-0eef-49f7-8d3c-bf7bb16b49e4@linux.ibm.com>
Date: Thu, 28 May 2026 09:52:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526015323.207343-1-freimuth@linux.ibm.com>
 <20260526015323.207343-2-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260526015323.207343-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a1848ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=07d9gI8wAAAA:8
 a=VnNF1IyMAAAA:8 a=BwH0bPgzfbDwzWKgTFEA:9 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: wbenrYLiUpfIk6BnbK6lkXduy98xAEAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfXyjKz7ao86MHt
 k834g/ufWyH4QgW0PUcGxXHnjiVqnGYb/qMtHjWPZqpyU3Zv8JCky8CXmFNyhIuvyodd09RODFs
 vYgVfICwKY2vLG81bcPlY7wUfhim4p2VGyYWf3Ub7Vt/OyI5c7SDV1/t6IJf4xKOQj1/IvCKP9e
 ait6PGL5foAOFTxGas3blNbWk5toRyuRlrCqmtHD+R+GaOeygWwDOtX7VrUbMVrXVFZB10WjdWA
 C84X5mdmxVZhidmwypkYmjGmqvYWbjvXDgfy3BK7lEA475Ff1QrwgPYIBK+kbJzJRiIsBGFrhe9
 abXgEMjMgBTQ3s5h5HztnogfoDrS7ukER9LUfx4RpoMP94kAaYnPAAwcIfYIebktaXLSasFYedV
 ql9XEFzrQ2mswtVAdHBLoHWnbbz3zH4YQCGm3/cnzwQGMhM/k4FSJ/kV6rYMk8wN6KLZHKIYHjz
 V7SGGqEYjy9s9d04Adw==
X-Proofpoint-GUID: wbenrYLiUpfIk6BnbK6lkXduy98xAEAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280138

On 5/25/26 9:53 PM, Douglas Freimuth wrote:
> s390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> pin_user_pages_remote is used for both the ioctl as well
> as the pin-on-demand logic in adapter_indicators_set().
> 
> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
> in Secure Execution environments. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> will not be incremented as the adapter indicator pages are not mapped.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>

I gave you a reviewed-by tag on v7 with the caveat that you move the kvm
lock earlier in register_io_adapter (which you did) so that review tag
should have been included with this patch.  Please include it in next version
or it will get lost.



> @@ -2412,6 +2412,7 @@ static int register_io_adapter(struct kvm_device *dev,
>  	struct s390_io_adapter *adapter;
>  	struct kvm_s390_io_adapter adapter_info;
>  
> +	mutex_lock(&dev->kvm->lock);
>  	if (copy_from_user(&adapter_info,
>  			   (void __user *)attr->addr, sizeof(adapter_info)))
>  		return -EFAULT;
That said...  
Please also handle the sashiko comment for this patch, you moved the kvm lock
earlier like I requested but that means now all of the nonzero return paths
have to drop it before returning, the above is just one example.  

Sounds like a case for either using guard(mutex) [1] or something like

int rc = 0;
if (bad_things_happen) {
  rc = -WHATEVER;
  goto out;
}
[...]
out:
   mutex_unlock(&dev->kvm->lock);
   return rc;

[1]: https://lwn.net/Articles/934679/
