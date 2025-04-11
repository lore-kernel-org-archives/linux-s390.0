Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB91993A3
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381513; cv=none; b=Tscs3lpk/gt67cdiBXJXFkkGWv+pM8dw4CCKWGEuVAjNOndo93fSqYGc2J6GNZTEZl4fwEoT2JAiuBaWbnnqb/HgYKz0Y10FY+FoyLXamkF122zovUlPH8oExyOsoQoEoDBBMiyENN0iEi879Ipb8EqCe4a3RZ9L4Jlf7RdvXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381513; c=relaxed/simple;
	bh=lFTeYYOmcBgcKdwbXybqDiCqxNB/Vlo5MmUph0b1qzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSqgxT2adtrf28gpT8oEYZtzbUV6AT0sko+XprZgWvk4SznJgHeHyxcdM3x6ZP+vXHX0UI7ocCwwzmXZ9DCgA69FrKL6E2TWn7c3+kUYZCGA0D0TJ66ArdkPxe50JA/1DeFCEy9xpG9G43GPme7l3K1840mfHLgTbGMERJ/MmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e8cg3BYB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e8cg3BYB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE2HMa028849;
	Fri, 11 Apr 2025 14:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=knY3QK
	bWKaFUHWikYp6p6Ilk1s5x+JqXiAa7AFRv+Uw=; b=e8cg3BYBa+a3XQeJUX4Zbu
	AeAtTD4WQZ0ArD4fxkmHrDdMtcz2AwKr5SxIggRHtKJf6+SwUP+EQ65EkwESExRP
	3W3MWZavM9XeTGfBkMCM/6BcH6oNMQJjr1CIg3S0O0ffDD+i8sjEpnrjzq+IpoFt
	GzHqv75yyAl3ugdQubwsPYoR/Snzf+LnbUa+xvQwFWgrlL5LADrM8INC5p6/D/Ms
	PImtT4QZujuOHPh7P0z2uFQpqPvRcNTnONE6wzK/WYDQ0nRBur4AjWD4XiRbB7cC
	cgkt1T5qeOMmc/PCnmNFNTjjhJsmT8BGZ/mXAbExc3ReAI6b+Hvf7E64n4AMBZow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufaasfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:25:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BC5ZTp029592;
	Fri, 11 Apr 2025 14:25:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k796hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:25:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BEP4Id21692706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 14:25:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD10720040;
	Fri, 11 Apr 2025 14:25:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B1E520049;
	Fri, 11 Apr 2025 14:25:04 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 14:25:04 +0000 (GMT)
Message-ID: <00904381-9386-4cca-80be-29ccce2d85ec@linux.ibm.com>
Date: Fri, 11 Apr 2025 16:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/24] s390/zcrypt: Propagate xflags argument with
 cca_get_info()
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-17-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-17-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Iw0B9-Zbfnw1BPpn2ec3zTdhK4gZz-dg
X-Proofpoint-ORIG-GUID: Iw0B9-Zbfnw1BPpn2ec3zTdhK4gZz-dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=767
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110089

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Propagate the xflags argument from the cca_get_info()
> caller down to the lower level functions for proper
> memory allocation hints.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

This patch will be affected by a rename of fetch_cca_info() to cca_get_info().
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

