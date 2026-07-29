Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932794772BA;
	Wed, 29 Jul 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328127; cv=none; b=NgzZR9Y6wIiZXa2PwnQYYBVrHUd/Qsk9jFg2GOeJWkpwjmgUJS60wDYk9uOXm32r+xvq+puEXtkDWT9deyiXk7yOH0LlVzZosJLzawYvQ+G3I8i3kU4DDyywUACmmiUYXAAsySNq+NelbmPw1zN97iwbx2SewC9hBx6KVL8sQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328127; c=relaxed/simple;
	bh=dz3HCe+wZxU9P5mKArryicIFj2a20GbaUsg7vh4pMCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Itcx1sy0DEDcA1+sCmf0VuSL1oqL1Q10D2e8bPdylsfHxfabhJuLaM5xm0/S+7Gz/YJBh0WFAESH8F/zv5/ruTZc0X3EcYo4SofOhHKEwJeiZ+C1CFoGOqIgDIn6ika5dsGkqMwn1mtcs9UbZi20WaDlKPy+oxaTSo3EJEGdQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wm4hc9qW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wm4hc9qW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHu9L4030443;
	Wed, 29 Jul 2026 12:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NFKllh
	/2wGS/d8YNfaTfR/QifYG4CSJlH9FvcuyjiR4=; b=Wm4hc9qWGOANlL5I6y1Rcu
	/p4kvTxfNk32Ub8eHJ7bkoLNhmcoX1f0azAqAxEFBlSTPYVB66/N36hbYXroU9OU
	j35cuzeTlPlnpEJ4Ss0R0n5ONwnvfh+ztb8/lbPux/dFVz7nZZxRE0uRmkrb+IHh
	JM/PLMjulgeh4yT4vOPHWsQYcOQbt8aPGwd0R0eUVghumf/rR34iGt1MlCHDvoiy
	Vgms7/FuWBJNmAUm/ndvNyz0eZD1V1CHQ8n5OAjNgyjMxN+jYheefCZZeEiy49s8
	GUJZE6Yp/LTUeFYG6j0aZUR9OUKII3B2fZFy4yqNUsQlC3AKWSptfkwsp0iBDOvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7jkgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:28:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQI1u008868;
	Wed, 29 Jul 2026 12:28:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw6s71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:28:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCSTRV29229352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:28:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7092004B;
	Wed, 29 Jul 2026 12:28:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C3D20040;
	Wed, 29 Jul 2026 12:28:29 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:28:29 +0000 (GMT)
Message-ID: <c318813f-521e-4ad3-8cba-b2444703ecc7@de.ibm.com>
Date: Wed, 29 Jul 2026 14:28:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] KVM: s390: Fix unlikely NULL gmap dereference
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260728170708.294400-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sEULQp11A-S0uilTdm_gU99Z8_kcLH6s
X-Proofpoint-ORIG-GUID: sEULQp11A-S0uilTdm_gU99Z8_kcLH6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX4xzV3rC9JfF3
 B77dhcXq0JPOyFudGnhTY44QUSq6YwE8thJ2VrgYpBaDfiTt+uAmFEpxpJjIL7objOtgjM0IsZc
 jaLGlDT1ek7ii2EYpT6cp3wNqf5swYB1Hbcbn5o5G0Rd8KuYO3WbRjLdkY4R3YNww//yjXlXjOi
 MPb+0QFEyRMfreNuTkh070RF8TzXyxUb1952K9FlJQVl3ngI+dmxSaNuT8OmuA9v1LCC/3CnlYq
 AFPHrHBHnVGwyC8NHvg70nlxDDqMDGfgm33nkrT78I0Wgl2M8u6QmmE9My4P8m7E3P9WnSIsax4
 SgRD+RecVTQgBGy54hdIKB2gV8Lbmw+BO6KFby7yg7nuDggrIKr/7VQAS2BVmiVsiy7IMV/PA8Z
 cTUTiajjR9yjqd75jolL2hSXx6AeBxByCVkiPKHe7/TbnZGBNmWUH7lWfSNBtyEyl/sqJLUUZ1F
 qHapDpFULoL4+d82jUw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a69f1f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=_BKb5qho9Nre88LnVS8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX3HRyr0e3RoYW
 8zwOwFejkorPkAV7gzkw2kprjFNnzKQ1x0DJkFhmpk2r9GY+YR8Mm19Bi24wedvZK+UTmDjXQ+k
 aCwp6p4pZRFXZ5IGntZYsS3wZ1MzCg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290102



Am 28.07.26 um 19:06 schrieb Claudio Imbrenda:
> When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
> kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
> has been created. The new file descriptor has not been returned yet,
> but a malicious userspace program could try to guess it.
> 
> If a malicious userspace program manages to start the newly created vCPU
> before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
> dereference vcpu->arch.gmap and trigger a NULL pointer dereference.
> 
> Fix this by adding a new field to struct kvm_vcpu_arch to keep track of
> the initialization status of the vCPU. Refuse to run a vCPU that is not
> fully initialized.
> 
> Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



