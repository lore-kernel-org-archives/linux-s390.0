Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F2C43219
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jan 2022 15:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiAYPAd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:00:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1389531AbiAYOzF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jan 2022 09:55:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PEjuGh031767;
        Tue, 25 Jan 2022 14:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Zw/loyjbTJxxS1KmfvpvDiOMIK7PqnEtAuLCUVE1xtU=;
 b=G2JeIe/LF2cpEiLor6snigKTnwaQKwx1+xbYwinhT2fAjy70G+BwzAVHLrH7RVqHF5sq
 hZw61qnmNtrtxoEGwtu/r0Uo+Olgoa3PLUqvBuG47Jc+zVDsg240khTFdAr4Hf0+7hNl
 r8whSFh76h10sg2U/nptOpWqnIU5zcc6BRW3UPO+xy5ExUzECDUc6TAvW/op4zy8YJe1
 6wYFFLp39+H48KrH+MdOdWkf97HlCb7E4Vb3UQFoj6AiO/h0EfNy6cZkLlPbjkxT2urc
 /iya1LoBxP1my9iEd7IRESpntEP7C3Nm72YnvdQ7t0+YKuziWYf6ZAvQM6+L3m0IvVim JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtjrt8u7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 14:54:57 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PEnJiQ008561;
        Tue, 25 Jan 2022 14:54:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtjrt8u7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 14:54:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PEmKfm028083;
        Tue, 25 Jan 2022 14:54:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96jf9x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 14:54:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PEsqtW35258672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 14:54:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D7842045;
        Tue, 25 Jan 2022 14:54:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D2194204B;
        Tue, 25 Jan 2022 14:54:52 +0000 (GMT)
Received: from li-ca45c2cc-336f-11b2-a85c-c6e71de567f1.ibm.com (unknown [9.171.17.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 14:54:52 +0000 (GMT)
Message-ID: <c0b5e6151a330f58f6794ee4fac19e6319810613.camel@linux.ibm.com>
Subject: Re: [PATCH qemu] s390x: sck: load into a temporary not into in1
From:   Nico Boehr <nrb@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc:     richard.henderson@linaro.org, thuth@redhat.com,
        linux-s390@vger.kernel.org
Date:   Tue, 25 Jan 2022 15:54:52 +0100
In-Reply-To: <9a888391-1020-89b0-65ed-5c93f2cc8642@redhat.com>
References: <20220125122914.567599-1-nrb@linux.ibm.com>
         <9a888391-1020-89b0-65ed-5c93f2cc8642@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j2mzPcFZN9am7iyrCWArefBvGfbUP5Gq
X-Proofpoint-GUID: FevJGd15Wo6BZrRBkyPBBot0I4tDtrOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_02,2022-01-25_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=917 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2022-01-25 at 14:13 +0100, David Hildenbrand wrote:
> I think you can actually just reuse in2_m2_64a, similar as we handle
> SCKC

I tried my SCK tests with your patch, it works just as well and seems
much cleaner, thanks.

Do you want to send this or should I make a v2 and add you as
Suggested-by?
