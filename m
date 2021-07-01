Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622FFC11F64
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A54D613FB
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 15:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhGAP2H (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:28:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232817AbhGAP2H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 11:28:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161F4Q4K040717;
        Thu, 1 Jul 2021 11:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oETp4wcH8qi4tT8W+8NM0k2YuYCHdgBjcXm/KqSgA80=;
 b=cYc7fP6O4k+4NKgbvZS2DLnX58IdX8j/JjASZDelCcYLs32B8yOaZV/m59YSEOO0/kSi
 9h2+76ELfSoddigdZEJloiZAo8ZHq96rYQlaegnPCfaeaLjIireUnCz69C7QXYBMzotw
 42sjNHjFrDxf3v+x0tpLCPzyaiRZzwjZaSggUI8XHjgCQ92nMLqYEmDmttf6dNJgZiSa
 uewN0LlUbJMPY/iweJS63JyFgU5uHUkV1YzhM9UAjYcq4cuSVa5qVt0H2fiHrp7T8NMj
 FVxs6Bdx1y4nS7SiXTwp2fjQQ2rpRfAXKanYhlg+4V0qKH/pi+GRGLiqCGIixc7UE3C3 bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39he8emec8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:25:35 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161F5pBZ048193;
        Thu, 1 Jul 2021 11:25:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39he8emebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:25:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161FFpqf008903;
        Thu, 1 Jul 2021 15:25:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39h19bgfge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:25:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161FNoMC25362728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 15:23:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4841EAE05A;
        Thu,  1 Jul 2021 15:25:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEBF1AE059;
        Thu,  1 Jul 2021 15:25:27 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.22.223])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 15:25:27 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-3-akrowiak@linux.ibm.com>
 <8936a637-68cd-91f0-85da-f0fce99315cf@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <53181dcb-cabc-d6a1-3bbe-7eba298f06fe@de.ibm.com>
Date:   Thu, 1 Jul 2021 17:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8936a637-68cd-91f0-85da-f0fce99315cf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MOmGIV0Y-A3aZdTSZKN-1gxhbSh7WZV4
X-Proofpoint-GUID: 2fgLdHAGspMhJI5uPIkQtrHpLqAHjBn0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107010092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30.06.21 17:18, Tony Krowiak wrote:
> I assumed that this patch would get queued along with the other one in this series,
> but it looks like that was an erroneous assumption. Should this also be queued?

Sorry, this is on my todo list.
