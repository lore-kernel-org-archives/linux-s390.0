Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C7375F82;
	Fri, 17 Apr 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418937; cv=none; b=b9iUHNJ12f6o2g+cFXHHu10pml57exWO9eSJoNwdpV72D8UVB72h3ApyNthO3V7tI7gmK+jLyOWtIoLfJRBZFL20cfAHh9Md0AFHkVfqFe4va47VlkC4AChtOm4fAKKjgLxNPEZ/1nX6YecXdCZKue5NISkFZnOFVS6vOfpplXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418937; c=relaxed/simple;
	bh=d4VmaiItszQwrsvXu1IVbaVVxxyKa6QvlgWXdqqFYq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOqy6ep9EMNtFCfwQGAk82kP+rsVbNdhk3SJek2P6L8KcLc8+aLmQnSocYx2avKhTV5bUqzD0n469QMDeO+9ZQobpuA9INFlZ3Hb1NiNpAKaCO441LM4G1MkHlJpbMmA7q6vOdWOWUf438qG7c1nWaueZNpnuqK1Et4fy46lu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JPn3K+iy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JPn3K+iy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKbtJw1805495;
	Fri, 17 Apr 2026 09:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=Yclyr9usb494wpo9UGwczj/1b3/qLhfDnMPsV4lr9as=; b=JPn3K+iyX3kn
	Rhr0FRjJjCa3MGHKFTuHuOXl/lrKVZ0Zli0x2m12sHF0Kqh+te5EaYTE6y0glWHB
	qZboPw8Gv7mRMxzIIdt+K4onrxPrAqwK/n64iu/xNJJzwmGTa2vG07wDAW/2uvPv
	LN4ZqKS7FCd0DjF/BV1YeOC4u7TaaBezx9W8Rl8byPeSnQldzwkKwVjmQxN7j0Ko
	RSPzgbhR/x7dHStpzkIxlrhwoswzKgKtWAlvrFtk//hX/nq1V00Wwd+xmuRLoZiQ
	wC6tg3n9WQpjJ8w3GYkyybNATzHh7AkK4AF8pDKzu48KO2eDejDRbIUPp1nGmExj
	eu0KgQMufw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kgq7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:42:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H8Y8n3025643;
	Fri, 17 Apr 2026 09:42:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujxf9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:42:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H9g0s525821500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:42:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1128F20043;
	Fri, 17 Apr 2026 09:42:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 005B720040;
	Fri, 17 Apr 2026 09:41:59 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Apr 2026 09:41:59 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wDfi3-00000005wlO-33Rc;
	Fri, 17 Apr 2026 11:41:59 +0200
Date: Fri, 17 Apr 2026 11:41:59 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
        Kees Cook <kees@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/debug: reject zero-length input before trimming a
 newline
Message-ID: <20260417094159.GD28991@p1gen4-pw042f0m>
References: <20260417073530.96002-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417073530.96002-1-pengpeng@iscas.ac.cn>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9pSW9i038oPHejctRDWOpCY2z8ZNxhbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5MiBTYWx0ZWRfXzrxbAShCDafk
 6VdBXJES4/8i3k8d2lXD4hvVdGuKdzuOZJJG3+oxou8vPodk6cyYVkDWBHx/RxWwI0ZAFntHocQ
 IqoXH5TAliUetPLsbcY08FFGAASRLu4BTxiU8zhg80jbRajHRE8Tb+VLjHiK6TFwmCcHYcMAOpM
 eyPEPe/jqLWdwEQnWceqSk3bw8DcRV3LKLu1Z+5iFxAiFQAL6qlDsWzPVLQfsaRomsUlG2Y7nMi
 oZ3dJA22/T+vmV8KF32imrYopkitCA8znw4oIGjiUfcsPPzE95dP7dpBBT9pnzbkEjMY/61d9Vo
 yfn4/LjCrNNk5LamEPKSMMd1FAQNB3ycuOENVS9rvy933OAQ8Ms7OJPurnmifhqXiFP30DSaCtR
 sdVVY5Nt77IlwVNep+tG7QURKJiQhlLSfEX36fOb46BYHROewRK74yKx8I5QTfqmy4HpxXNaNwl
 tWoVe6P1S87x6H2HMjQ==
X-Proofpoint-ORIG-GUID: 9pSW9i038oPHejctRDWOpCY2z8ZNxhbO
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e2006c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6aPio0FCpJ9vPV8vH-IA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170092

On Fri, Apr 17, 2026 at 03:35:30PM +0800, Pengpeng Hou wrote:
> debug_get_user_string() duplicates the userspace buffer with
> memdup_user_nul() and then unconditionally looks at buffer[user_len - 1]
> to strip a trailing newline.
> 
> A zero-length write reaches this helper unchanged, so the newline trim
> reads before the start of the allocated buffer.
> 
> Reject empty writes before accessing the last input byte.
> 
> Fixes: 66a464dbc8e0 ("[PATCH] s390: debug feature changes")
> 

There shouldn't be a blank line here.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  arch/s390/kernel/debug.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index 31430e9bcfdd..2612f634e826 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -1414,6 +1414,9 @@ static inline char *debug_get_user_string(const char __user *user_buf,
>  {
>  	char *buffer;
>  
> +	if (!user_len)
> +		return ERR_PTR(-EINVAL);
> +
>  	buffer = memdup_user_nul(user_buf, user_len);
>  	if (IS_ERR(buffer))
>  		return buffer;

Otherwise this looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
