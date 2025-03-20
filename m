Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9322425B
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463113; cv=none; b=nh68GYylmuZX7QnxMkGdUum7MUFFaJB8z/qkhS97csgAilJBavkATarbBTS0Vyr57kjht28/CjAZGXQkIumB/SYelb7tCAx0i6s68uTi+BHd5ukqfwV+1VTKl0hQ43nUvJL9MbuYBN/cZC1hUMVFzt4pCCckYWagRddr9+nGFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463113; c=relaxed/simple;
	bh=wI6Dr8jvVgNBOl00r17kp0fPm4BMC6wICEALBuCQzk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+PU5sBSVj9L/gtlEB4uiNN696NW8VMGyhdPqBklqkN2ZXa9ht0p4DhmdTqylO7pzVYIbe74+JpFZ+pd35ATlZvImNne1t8C2VoohAyom4P5OWRK779xW3AJG5TPSWZ2NVSG3X6QhGIQqgabkPmbKoMHznIWLnvrp9knHNMx9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l4O7GHDu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l4O7GHDu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8Hted011898;
	Thu, 20 Mar 2025 09:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f0BeiQ
	RdIxFw54SFmrLCGg2WZ528eOMg0EqSRBBHGLI=; b=l4O7GHDuo2AFnez450vLNn
	wMbnVRczveIshXXd4Qe+95JCsGiVGLAz9fzY7w4Tt571DmLagevEwNAUmgz5ZvMT
	0XBlQgGUA1c1GDQ3U9RcKxkhXtVQuMDAg5ctLFQdK2+DtyH46XyxYzbgCscVYz2K
	RxPaEO+p0GeaCf9YwElvBl9Fujvi2SspJ1ibrf8XPWI9PfIlUaYXeNwf8oBqExOT
	SnuofdmN3lc+cbQEEsP84VyriGtmvZvXx+c9y6GR1t/p1CACERBdZDx3e0p1mdKh
	tE5oz22yIyDRQ3W6yBpScJDUxAYxL9627C24EtHEG8ropEpdiEtg1DdyF5k22DhQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy26035-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 09:31:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K99ogj024411;
	Thu, 20 Mar 2025 09:31:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmf2gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 09:31:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K9Vh5V20316624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:31:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C28C520040;
	Thu, 20 Mar 2025 09:31:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9384E2004B;
	Thu, 20 Mar 2025 09:31:43 +0000 (GMT)
Received: from [9.155.196.190] (unknown [9.155.196.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 09:31:43 +0000 (GMT)
Message-ID: <d5f8438d-92fd-4d76-b27e-15370a41c576@linux.ibm.com>
Date: Thu, 20 Mar 2025 10:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] s390/zcrypt: Rework cca misc functions kmallocs
 to use the cprb mempool
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-13-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9pFhql3uNk_9K2hdsO4wl-jTDqRbC0q9
X-Proofpoint-GUID: 9pFhql3uNk_9K2hdsO4wl-jTDqRbC0q9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=889 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200057

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Rework two places in the zcrypt cca misc code using kmalloc() for
> ephemeral memory allocation. As there is anyway now a cprb mempool
> let's use this pool instead to satisfy these short term memory
> allocations.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

