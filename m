Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C83DC4AE;
	Mon, 11 May 2026 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497159; cv=none; b=MNDG+rsN0lo7xLf3c6cjX/bZ/ZnWIhua7iGmju1uVqrNq7lCCqIgD8JCkrcSIaXlwepflccwOIkW5/wVkqx6az6X3/TPe+7E08P3zsiu22aqcMJ1i6/Gz41iSTRYcDcXDfq393xcbjWekWkt4wmAx64+mw87Uz5CqPqNJ6C9zpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497159; c=relaxed/simple;
	bh=gc2DxwpIUHKjBtX1JmA5H7O8FjGN02um1IzQrN/qXJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpODgvvvndb1lssKs8Ij6T4BONU1MHfMrTeDW4nhma04B08BiSNL7/U2xU4S3NTDuwQbyvNijoq6pWWE3UccwW9mqjCZeW+ZXjDdE8QzLGGTCLXOnbLe+YgpUQ3IvbzlU042u+BH+Re1uuysV9ao+A/vjIIE7I8KaMWvmZX5r5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lui/AkIR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lui/AkIR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALFAhJ3864008;
	Mon, 11 May 2026 10:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=q5kqPWfpG2YwyRciIXrlPmu
	/OQxVH/67G/Fbf4EwDRI=; b=Lui/AkIRbobUvpuLK5N6C2U/KLqZ2SJJig1IKPI
	amMJedrYO+Xog0cN9pgIJaTsJDPSSyZxq4fDynUgepcB83Dioyox7BzDMGtaNo7Y
	jKjY5h36TSSWJCosl5pl5uI/4b6EabXcJKqZMEVUBuCsvZAG6Ag7o20U93MBXel8
	wTLtj4oWPGLa3GSlmAWuI4svS50W9vGwsrYRDNQNkXHXRauvblJIZ7YVAt5HVbo1
	B06lJHaMla0jV6zoY1Q12pQXDfVne2CPugSAY9EYpLcOoFmHxUTnH9XlKGgrAgjG
	Lc14faP+CxQp1v6v8bHNkfuQilwiDdKyZQWtMx6GVGNu6Sw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4qv9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 10:59:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BAsbF4011225;
	Mon, 11 May 2026 10:59:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4r43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 10:59:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BAxBrj43713022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 10:59:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC64320043;
	Mon, 11 May 2026 10:59:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F7920040;
	Mon, 11 May 2026 10:59:10 +0000 (GMT)
Received: from vela (unknown [9.111.77.58])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 10:59:10 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1wMOLu-00000000Sk0-0BHY;
	Mon, 11 May 2026 12:59:10 +0200
Date: Mon, 11 May 2026 12:59:10 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: s390: Fix typo in UCONTROL documentation
Message-ID: <agG2fncs1hGjFBt8@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
 <20260507200836.3500368-4-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507200836.3500368-4-farman@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01b683 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=gYbddNRvOjDexA9mkPUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExNyBTYWx0ZWRfX8SeI423qxk+4
 F5j/pk4M+yKqIu4orw20E8s6cp5fkyKkKItfe8AGhXsuzfxqnyzx26Oc6l1dMVBfbXdgzzwii6w
 jx1ArhTOi77lo9R+iZgFvUAfgplb4oMiWgh7qoltVrJa70jHTnvzHzpufAfXp4tRPcqqOQNov2Z
 RmFd5zyElwY+PrEEu+dZzMJoNVNyzD9pIJ8JZtySrWkyIwxtRNnnJAt7ka0lOJFcS95wpX9uI6w
 jBaww79M1k5KwsYD+d/lou+1XRmfeFkStSLDUBlJkR9Q9K1kMCZ4Z5AGaIlvH70f25p1NFuNCPr
 ojx3b7fVX55d+TD+bTc5olGj+yXDq9kml+62vxnybOEr/SaRYwjpUiv0wkdfjsPWFcjTUO7eFZZ
 sAhwiD3BAE+mCjWe9l/rknY6eYcBxyWE6tcA4szZcMIou3OuArRn9idiHe2qvKgOMGeFfJfoDL6
 lS4zXEfyOFviP0zpf2A==
X-Proofpoint-GUID: 0MBUeMW35Vumj6wgKIzEGGQTAKnxU5T5
X-Proofpoint-ORIG-GUID: 0MBUeMW35Vumj6wgKIzEGGQTAKnxU5T5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110117

On Thu, May 07, 2026 at 10:08:36PM +0200, Eric Farman wrote:
> Small typo noticed while writing the USER_OPEREXEC selftest.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
