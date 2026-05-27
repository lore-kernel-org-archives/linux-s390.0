Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73223391E7F;
	Wed, 27 May 2026 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894369; cv=none; b=XJPvvu9WK+V9KxnvGnDSMA5xTvza7yyveVy4sbnuBY0FSzmoy2ufvXUsbAC5DefOzgJic5me10rdHkNeJee7DU3s779pm2iK4rXnOWKxRz8+QTLaMSK4VYq3ii74H1jpFRyl70OdJHXfiX+SulKJbdOWhtix2Dn4CY757BpWJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894369; c=relaxed/simple;
	bh=RsfjSdPS3FsOalRYjySmRZ6wI/wkCixF3/saE67AD6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS3pFsxOLuJcvgmm4c/u9oxwMkG5MDe0lj2LuGgikM3DDfUN41ezPMuEIz8x2pZOqataXBfJJbpsY5RIfSR72cCNSgY0dWZMXkLmZVE62qQtGS2iUeTRnOUE3PcoukvGlTCbqT8t48/F3Z1/EwCJDcbLbz2Dcy5u8vUlILtjN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iYLg+1FR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iYLg+1FR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCmeoo735911;
	Wed, 27 May 2026 15:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4/M+V/oY9D2n9kC3WcRNF0fEOu/EhL
	RwS3owsawK5jE=; b=iYLg+1FRtjGRw1LjZ7wdkGkQU2o/hDnd91uiluOkwwxFC2
	O4IZFmffF8MV0FzttxBxEMHpiEpLOTtnWcvSGVS3eVNwXANRYhotvMp/gv8nWEZT
	W/br42TY04FLaHzOCcJH/Doq+Hjq0lRZ5wPSLt6EFwZkmPOMsp0Q3uCeEmLtKJdh
	bWx5g7MTlJrRtyhsHH5t9E4Dc04SgDRnfzPaBo8Y6X5ltcMKDCL9kN9lyvAAd2TM
	2D0Th/wzwBc+TNTdmKZVQlasAfbCYjGWLVYHAUpEQPZXzS3uMT27Y1V46qNQbkUH
	E3mmVHm7bNWRoxcNOg8NxN16cUnjiBt8ixrGwNaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc8pjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 15:06:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REs5lv005364;
	Wed, 27 May 2026 15:06:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3jfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 15:06:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RF5tUM12321074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 15:05:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC5D20043;
	Wed, 27 May 2026 15:05:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6691B20040;
	Wed, 27 May 2026 15:05:55 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 15:05:55 +0000 (GMT)
Date: Wed, 27 May 2026 17:05:54 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, yan.y.zhao@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 0/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Message-ID: <20260527150554.361644-A-seiden@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a17085a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hYS-lhFIv60Om3WMZeUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IMQZWw-Ec8TABG63qYU3Q6yVafnuGb8z
X-Proofpoint-GUID: lxpu3190xhYYXdFyAKQfcraO2MsQNDjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX8QqIeMPhkXId
 OWDVh3Xd9eRATwgkX2jG/oUjY5zPBNJufAECw5BeCGgFdNbT6Ni+h90tz1nbIXrZiDr6lBynKft
 s8wuSo/G2oZWGeFWp228pPt8D6yJhoojY2E1TniK+tq8ueJwzPL8EqCEG47L0+EaJ6GDsr7bwsX
 LWWTHzLrZ9X3LzqAQzI/sS9ivPxth66xSHP3YpG4cDPbQQkWqvVUCZoEMqjQJ3Q7kojDK0EyvXe
 FE9VHMBj0ECZcmCqUECPxdRqDLcTs+c7ehkATx25otpymGC2/xEMAvlfycgXijj3KyCDZB5Fkog
 9+LQvRpkZYyS+CJ33vxZsrdjE0EsxvEwTCyfLAK3B6059/FOkR7v5j399r2W/49oPK5Qe63oPmP
 1DvxMoxVtZKlZpy/hedEWaaaO8LzcMwlQLBKIXhyD5p4S7eMuEwUIC6Ylsr2QXLazbI5E0A7Dp1
 OcK1Z1390xbJ/gs+FPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270144

On Wed, May 27, 2026 at 04:43:53PM +0200, Claudio Imbrenda wrote:
> Implement KVM_PRE_FAULT_MEMORY on s390, and update documentation and
> selftests accordingly.
> 

...

> Claudio Imbrenda (5):
>   KVM: s390: Track page size in struct guest_fault
>   KVM: s390: Implement KVM_PRE_FAULT_MEMORY
>   KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
>   KVM: selftests: Fix pre_fault_memory_test to run on s390
>   KVM: selftests: Enable pre_fault_memory_test for s390

LGTM. 

For the whole series:

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


