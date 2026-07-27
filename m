Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D23BE17B;
	Mon, 27 Jul 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137363; cv=none; b=RJLuzL+5clvi+qH+Bf1J1W3TkHwYGipYZe4nUNuo1KAb1O/gtT4O8cnRachcKa0UfOJEWaCNRGgS6CJdEFkxqjW+06ncYdzEnae+Mf+3SXc6tHdkbDR0tbfwPGOsKMgFb7dUawLKVD33UsscUdVuAwZOTw6vH1CXxzvQQvbDL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137363; c=relaxed/simple;
	bh=5VnJK5nCK4B8ovKaZDETcBmtFzHSqsIVtURGVrMzzZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kprrEW+kmx/LAg0wDBVa56RBOkM4v+6A79IRxmyyC+Ur8RJq7U7pp2QcInFKW9VXrcbtazu69ndYJcF6WH/JiV47viTBAZygAUEfwCBQGW8VyBHy+M2hq6aMPL1t8TMyq6rVSKguwEi5T6oYr7l54dtLldonfhXckT4shU40UDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hK+kolpy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hK+kolpy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1m3Bm857259;
	Mon, 27 Jul 2026 07:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vAHzgw
	IszuqroWs9mxffLOI2MudygVbWhq5ouq/iDM8=; b=hK+kolpyTA0JsS94elj4fJ
	6VXUElncpWTuDqqgO/KUYOvrJaMw/aSxBPZ8oaNagtC0gojzximeHrsuHb0mBz4z
	TWg54IVmcnEpteuheUyjqUSPrO/v4H30NHLgazpGehjjoyEaQt3uK8Kr5ahwvpMu
	i/XWKwrcjtzAGE+icJLXY/Z2QOkQkxOw/G0kx5oIQTnbIxDtiXgbw+qbHRjIizQz
	25NwbmrV9ZGIjvqElUf3MVOcjsUQqTHWa8OxzzGvRaR3mLudNan83MO5lXoAIqFV
	ICr5J6MMRBX1sMdxbay9TUn9T9E7k0mJK8ufile8H0nV3qWJ4Tw7jkidlMD9T2Sg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw76r4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 07:29:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R7QspJ031566;
	Mon, 27 Jul 2026 07:29:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xv37g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 07:29:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R7TFu745089110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 07:29:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B76E200B2;
	Mon, 27 Jul 2026 07:29:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2722F200B1;
	Mon, 27 Jul 2026 07:29:15 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 07:29:14 +0000 (GMT)
Message-ID: <b099b7bf-31c6-40ec-a43f-9081f2c64195@linux.ibm.com>
Date: Mon, 27 Jul 2026 09:29:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Jaehoon Kim <jhkim@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        freimuth@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724133943.1664961-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260724133943.1664961-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dGmUfxoYwErnI3enYVIB-XijHjInoVVS
X-Proofpoint-ORIG-GUID: dGmUfxoYwErnI3enYVIB-XijHjInoVVS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3MSBTYWx0ZWRfX9q/xSnmeJ1f3
 7L1w1LPkNo5fahGOGoW26iLT6Du4WpamoLcNPG744yDnXz78i0HGQL7t0Vm9A4xZHW0Ue0UZ/qx
 Hmu9vW9EmWnXnliABsWY7btnj4gdursD2tg0EUfvU/9UoxjfJOgWwqozCmhv52l/n7WPvq9VcoB
 46BddpbDLmuMdc6pPC0r2uhF4Frc74F3wQm4xRYpqQ5i7riQRKjvT67NLYyE52ziwtFTTizJhKD
 jVHLBZBQfG9BXIsD8/NhM3cp5XadQ/K0r3KcW5gqzWfbWS1sf++DbCKcMjgPDu+7HCHUURBOT3F
 4yzs49CD477G54NAmhzuCM3WaqlW47iIGUBp7BVjXTJ53QqpMnQ6WbgvF4JLQwUxKKl2+B5QitA
 OQoZkRXxWLUauaJiHsQ4kQcDpLyYc3ycLvCYtoNgSCM/6pTv//+2MKSye9WogLS+pVouAivejr7
 J7LaLROE2uXrR6M3qwg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6708d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=q80BRJn0ysiKfIIGJVkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3MSBTYWx0ZWRfXwPa+DhqpAO1Q
 D1rwYDhUH/0D/Fo0EjB8xk0wc+coancl4iiI2ZM5uLO8xmlMio8i0wJt63jBvpHwwMDfYBgld6w
 RNTqZzBsNKtcQ3A2oYfpScuH339no9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270071

Am 24.07.26 um 15:39 schrieb Jaehoon Kim:
> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
> irqfd adapter registration fails even though interrupt delivery could
> still work via the existing non-atomic path.
> 
> When FOLL_LONGTERM pinning fails, verify that the page is accessible
> using a short-term pin instead. If the short-term pin succeeds, unpin
> the page and add a map entry with pinned=false to preserve MAP/UNMAP
> symmetry. The non-atomic irqfd path already performs short-term pinning
> for interrupt delivery, so this restores the previous behavior for
> memory that cannot be pinned long-term.
> 
> get_map_info() is updated to return NULL for unpinned entries so that
> the atomic irqfd fast path falls back to the non-atomic path.
> kvm_s390_adapter_unmap() and kvm_s390_unmap_all_adapters() skip dirty
> marking and unpin for unpinned entries.
> 
> Update Documentation/virt/kvm/devices/s390_flic.rst to reflect the
> new MAP/UNMAP behavior.
> 
> Fixes: c9a568838086 ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Douglas Freimuth <freimuth@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

queued for kvm/master.

Doug, Jaehoon, Matt,

can you have a look at the sashiko feedback for the pre-existing issue and work on a
followup fix?

