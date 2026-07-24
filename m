Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E48292B4B;
	Fri, 24 Jul 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897349; cv=none; b=X9RkyGrzId9a0iDiRD9yw+X8Is6Q6T+fmhBcUkRx9QFoQmLqyBddNoAEqbHIMdIbk1deWVbDz9G6jruZuAIZQwFm3Y1xG93bixBSgN12ARU9ZNm8N+V9kf1JSrxEqG3KMTNYc/4RNyBUmlXp0/Gd+cvQwXTcjAmjbpS/Fd13l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897349; c=relaxed/simple;
	bh=9F4fyssXoN1f4nfT1tLHid0LffSsbROwAuiOac6vaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLIx7cUbELtOETaF4Htq2uCXZjmIricNcJYSBklfcEVtI4ByWAYBH9bZnyvTWDnkGyRF/l+ELxItgHmg9S5Ll43/kO2vynzdzRgsi+fK8ssNHcQX0OKhnQGVhTcqNLsTOkYGys/+pmaG+C1cCVWrEDnKhOeoD9kCBi3/UDlBMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dToZw+DT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dToZw+DT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCglpA4165848;
	Fri, 24 Jul 2026 12:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=2t6yw+Hp7C5MWGnsJ9PC0chRspCujAVo+JwYpTq9DHA=; b=dToZw+DTStg7
	jOjKMVKwSrHWHJLFKGaZ60XJmGWt7IykfbahGPFRNPBNo6QxzaoC82vKKIwm1zSt
	t5DwygOzcu6eXL7zxtk4wzQAs8C/KDIwrUzuULZHj2kN6ZBMCOivIZdn5l8JIFjN
	/udNRHn+dRbzxmyVh5UuNFBKbEdOUb7ajgOdvK14qqgp8yKU/4d4pMf8Z8USg3Zj
	qk8bY4kJqoZ7GKE7pijPJuNqAMiwtEdycukeClbD5N5+V2j+qv+f9IrGUQLNRYVU
	CoVY9G0M7fGq07bwY4ztRwZ2LIMs6iqPbNUcu6J48ibVcEynoJCfXCZGQRpHZMcc
	smpbDObD2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77avq36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:49:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCYhN8002614;
	Fri, 24 Jul 2026 12:49:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wh0pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:49:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCn1MX29688370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:49:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D59E2004D;
	Fri, 24 Jul 2026 12:49:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 488422004B;
	Fri, 24 Jul 2026 12:49:01 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.224.78.55])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 12:49:01 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.4)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wnFKm-000000025Kq-49zI;
	Fri, 24 Jul 2026 14:49:00 +0200
Date: Fri, 24 Jul 2026 14:49:00 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre card
 status reporting
Message-ID: <20260724124900.GA14631@p1gen4-pw042f0m>
References: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gmG2nsTy0uvMZL-RXEKyniKjHhwmi7uj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX2qAnc3gOY7Y5
 oSbTgZPlpc+mpMEFowfKO7m2u9K21Le8o8scQjMRJ5vVOQFf/11vAoCXESnG/6sJTPl9ZlXvzLJ
 NAQ9omAN8PuCcPcOcI06o0aQt94gVsU=
X-Proofpoint-GUID: gmG2nsTy0uvMZL-RXEKyniKjHhwmi7uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX31Psczwrxhxh
 p4bTrGDq2QR5+g4TL/4mFaFXi973QyRoOhDIfmUPPpZfbTrIGcWAkzoC9q0rNxKqNTlpX5vm7xH
 aTbd7EKuzYaxd5JRsjTAWccwH2R9IIer7wmPzwdm0h8xvXhtrrGo/NElVpD5/PwOvxEzf6mgUsa
 gY80K4Na7Ftzv7i+WPKkedLvx2/fhTbl9RPIZxU+gcEA1tYP/CQ4tCnOvP4DXcbVhczt0W9Vdwn
 zHf4QmEzv0JqBZrjXe5jRkIKlx+uglo9nHRm54ViL9ifZqUdAKzmloV6/5yYX6Qti7DwXamu+Jx
 m6AvrcMeAF44sRpbX7y94FS3vvvF0c/NhJtx4n72Ync8ywYiMdM7iZVBQ8bXTrK5jYE3wF+j2n6
 1ygyNnE2u3aGKAzWc7RkiC3STB16KUDjNDSJwZhw35aUmGG4FdSdQykFngUivIF1JKB8wFCzoR1
 fi+NtGZ/a6qBYTYK41A==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a635f42 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aIFbZwkKMCHMwrlPlFQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240115

On Fri, Jul 24, 2026 at 02:23:01PM +0200, Niklas Schnelle wrote:
> Add SCLP Action Qualifiers used by the Spyre stack for reporting of the
> card's initialization status, recoverable errors, and telemetry data.
> 
> Co-developed-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/sclp.h | 3 +++
>  drivers/s390/char/sclp_pci.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index f2d490558054..44066550b9b1 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -21,6 +21,9 @@
>  #define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
>  #define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
>  #define SCLP_ERRNOTIFY_AQ_NVME_SMART_LOG	4
> +#define SCLP_ERRNOTIFY_AQ_ADAPTER_INITIALIZED	5
> +#define SCLP_ERRNOTIFY_AQ_RECOVERABLE_ERROR	6
> +#define SCLP_ERRNOTIFY_AQ_TELEMETRY_DATA	7
>  
>  #ifndef __ASSEMBLER__
>  #include <linux/uio.h>
> diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
> index d61a7fc0dd61..b79ef7006e46 100644
> --- a/drivers/s390/char/sclp_pci.c
> +++ b/drivers/s390/char/sclp_pci.c
> @@ -99,6 +99,9 @@ static int sclp_pci_check_report(struct zpci_report_error_header *report)
>  	case SCLP_ERRNOTIFY_AQ_INFO_LOG:
>  	case SCLP_ERRNOTIFY_AQ_OPTICS_DATA:
>  	case SCLP_ERRNOTIFY_AQ_NVME_SMART_LOG:
> +	case SCLP_ERRNOTIFY_AQ_ADAPTER_INITIALIZED:
> +	case SCLP_ERRNOTIFY_AQ_RECOVERABLE_ERROR:
> +	case SCLP_ERRNOTIFY_AQ_TELEMETRY_DATA:
>  		break;
>  	default:
>  		return -EINVAL;

LGTM.


Signed-off-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
