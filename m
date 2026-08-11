Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DA330D2A;
	Tue, 11 Aug 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481053; cv=none; b=SxVEGhgqvO/P7B6qUK313+GRyEFm+4/E7ziZBL81MwIYonXuqRqxWZafMAR0Zlv4CpVX9tY2Pj95zjA7pZqYPCwKfcF1c4lr4B5r4K6aZ0io1hZvfqrPdVBZMcWIeXINkE1+fIZ2ED99e4bK3GAxChETlrzT4FUTS3nfJXy+miE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481053; c=relaxed/simple;
	bh=ghutynPgu8p1zY87BMd9qH45ZDg2eVasdV7waSOi8rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1WeYemTHT46gtIjwMAC2QdtclmBxs8YauUa7iJOrlGlQkMeZJ8dIGgXtEL9moRHjExC38efl10XXBzfFrmb1NyDme5Rz9npbK8EV+9FrrPE/1QK9RRbiTrLzfhcCMOCUSVKTJfu/osNeqwNQMPNlWmP9+vVOKNpF4zLEdbMqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IIr8t7Cm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IIr8t7Cm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BJVVnQ1327808;
	Tue, 11 Aug 2026 20:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jlQEM0
	B67mc7Ns8QfSDXxeVcBaXvfkc9zNqRItDeSKs=; b=IIr8t7Cm/Bd1EN75Sdfo1Z
	VJfgDquGI+XbRCep2fb4k2Iy5nkx/F5lECN+6AgYPBj9ANbClp3TPJg7lciquuyS
	NogxrG2f+ctSPlbIjW5NIfKNVB+PPjMdz5px/hjn98xj5MUnq4s4dJSMMlzPAZz9
	BQoZ3XeSMzx5H4gkNcDzBNFMgWkfirKZGtHN+sMdjEN2VSLf935F1Hkskdg8kSua
	3LL38GJuxnQyab7W7eB9BE0k8kenuwSBJf2gPq8sBIuc+dnuer/6b5g456CDb/3i
	3u83XG7IzzPr20/luSpZ7IUYIy6j6omHj7Zh0sOljS0fUg5kH8qj6PEz2iyiKmzQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9q5st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:44:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BKfOZJ029656;
	Tue, 11 Aug 2026 20:44:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy2myp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 20:44:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BKi0c336045542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 20:44:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E79758056;
	Tue, 11 Aug 2026 20:44:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DAD75803F;
	Tue, 11 Aug 2026 20:43:59 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 20:43:59 +0000 (GMT)
Message-ID: <ee703b01-ea21-43c4-a38c-8b505034b0fb@linux.ibm.com>
Date: Tue, 11 Aug 2026 16:43:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] s390/vfio-ap: Fix hot-unplug skipped when last AP
 adapter or domain removed
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-9-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260810192257.1208410-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfX1xvESTZERLux
 DfbFnChO2Vrxi7v5fGkLRJ55hXCqSV+gTbWnBHdu9X0RRkBRPjES+LCUlQ3JVOYQSDAGg6z6EVE
 Q/iQCV2vfL7sfbngwTH1qhhAYr1zJV/y7iZpzD2VpPkDMJhez/AjrtefFXQBejsUI91jVtGWECC
 pSb54FCuCLsmNApYSA9ptPPt/7w7nWO2/9qiUx6Mzey3IE/uyw5a63+ygt42hzUhsr3PfKdvoAg
 /olUjXERgeu69UrtXjPuE6M1bDoyoVeSXv05UUEAqIzEC3gfkU4AqfiNx4Zwlf6zmqQ3dz7jxYB
 L0af0xcmovNvcwMHdOfEQ7rEPYKqlx/5djm/q4c35azZCc7GCbryby1hDroo0lOGomaaTFGvyBm
 46CFOBTb3ck9nobM4ZbTeItWOylpLDj0eU9bs/X1pl4v2Vi3jur3Fbdr4tf3di2I9o8lPjmfX+H
 q+gns3Oe0Djqd7tCNzw==
X-Proofpoint-ORIG-GUID: x7Yg1-cmNCD_Aqgj5fSNTTgz2mGNnovQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE3MyBTYWx0ZWRfXyzxgW6RpydYG
 xKvCIrEbPqiRLMsdxDtwU+ujHsYW0appC5BqQawtiTwn+FSjRtrmn3EwUBCETLET+5l2IpxocyA
 s51B5yShKFipMmsaLPWpUq7czviL6HU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b8993 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fD2uEicUE52K2J2evs0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x7Yg1-cmNCD_Aqgj5fSNTTgz2mGNnovQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110173

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The vfio_ap_mdev_hot_unplug_cfg() function uses the return value of
> bitmap_andnot() to determine whether the guest APCB needs to be updated.
> However, bitmap_andnot() returns false when the resulting destination
> bitmap is empty. This means that if the only adapter, domain or control
> domain assigned to an mdev is removed from the host's AP confikguration,

s/confikguration/configuration/

> the bit is correctly cleared from the shadow APCB, but bitmap_andnot()
> returns false because the result is an empty bitmap. Consequently,
> do_hotplug remains 0 and vfio_ap_mdev_update_guest_apcb() is never called,
> leaving the KVM guest with stale hardware access to the unplugged AP
> devices.
> 
> Fix this by replacing the bitmap_andnot() return value check with
> bitmap_intersects() to determine whether the shadow APCB actually
> overlaps with the removal mask. If there is an intersection, call
> bitmap_andnot() solely for its side effect of clearing the bits, then
> unconditionally set do_hotplug to trigger the guest APCB update.
> 
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Also please look at the one other pre-existing finding against this
patch, another potential follow-on.

