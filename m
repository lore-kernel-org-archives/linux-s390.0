Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA44C433E6
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 18:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE03064F1D
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCRSRt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232292AbhCRSRo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Mar 2021 14:17:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12II4Qjg069832;
        Thu, 18 Mar 2021 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SzXQ7yCsN5miftdT5GI2bJXtTdEaJf8wRL/IoI4yc7k=;
 b=EVP14V3tg/H/TwmBPPWw0xba1lWHBIdkMV302sPQ1DRNDU3br1h355h5mw4foVI9wVhp
 EvmGLs7PpoR3a0TpPMmCHWztlf/1EBrzWJw/Xlc1CBiv5hbriZAgFFOqiXez2koL7GtL
 gNKT0Iu1NRX/jTFgjzkIeyUs+c2iN6CoNEN08S0z7PaJun/Q2cnBgjzuImGPmBWTZCbx
 ripP9oXTgxu3ycvyoWfRNQRMakqnncSgYkXd322f7IZnin7474ECk3bMCtTwmNQjuDYl
 POUYv6JK7rxmhpN9zyX+WSquv3kidX8vukkNpXSlJO96V+zUX3/rHfHUG4YALP6Ffp7x yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c102ph6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 14:17:38 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12II62hv077842;
        Thu, 18 Mar 2021 14:17:38 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c102ph63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 14:17:37 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12IICdA6004871;
        Thu, 18 Mar 2021 18:17:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 37brpfrfaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 18:17:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12IIHWuw39846282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 18:17:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444A34C046;
        Thu, 18 Mar 2021 18:17:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBBBC4C040;
        Thu, 18 Mar 2021 18:17:31 +0000 (GMT)
Received: from osiris (unknown [9.171.19.68])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Mar 2021 18:17:31 +0000 (GMT)
Date:   Thu, 18 Mar 2021 19:17:30 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     naresh.kamboju@linaro.org, acme@kernel.org, agordeev@linux.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        lkft-triage@lists.linaro.org, nixiaoming@huawei.com,
        svens@linux.ibm.com
Subject: Re: s390: kernel/entry.o: in function `sys_call_table_emu':
 (.rodata+0x1bc0): undefined reference to `__s390_'
Message-ID: <YFOZOnrPCJtHl2D+@osiris>
References: <CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com>
 <20210318170501.2183418-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318170501.2183418-1-ndesaulniers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_09:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180129
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 18, 2021 at 10:05:01AM -0700, Nick Desaulniers wrote:
> (Replying to https://lore.kernel.org/linux-s390/CA+G9fYtBw0HAv5OOAycK2rZ_m2Sj73krXPJ0iDzT+O8qtc19SQ@mail.gmail.com/)
> 
> Yeah, our CI is failing today, too with the same error on linux-next:
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2138006304?check_suite_focus=true

It is fixed in linux-next of today.
