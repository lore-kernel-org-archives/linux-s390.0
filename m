Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EBC433E0
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D8664FBF
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhCJKBd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Mar 2021 05:01:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhCJKBb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Mar 2021 05:01:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AA07nK178088;
        Wed, 10 Mar 2021 10:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3hIbAOIIYkWPVyYUNSB6QicuWFCi9clw9fdBmM/IN3M=;
 b=MPpGgAlZA1h1yR0Ne3suBBQidIp6VCCqMsu4hnBTZIjdpoZvXJ+MSUhJS4iD/1F8QJ98
 EtLcw2VjQGrdomtMH2QTOwWhOhvcMtBtBExTlPGcsFsd15zbqEoMYuUgSUIqkFtBUYQX
 W+f6LGNLMxCf3zwKBHjYxhN0Q6mteZ+IcpYf8b5L+QVG6JejLyck+I8v48hMdM6MrmJr
 VJwjL9efpAx0yAfnYhVVq0bk0UR5aQbma+vA6pWhmxIm8tmd+cbaxgQuk5BFSMI+3YSl
 1eftNe9KGPAfsZvSeU7u1fo6FIGLfGrCq6Tyl+bdzjQ/wIEPxgRD/dvT/PdbNimVuqkb vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cnacba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 10:01:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AA1LXf103270;
        Wed, 10 Mar 2021 10:01:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 374kgt42t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 10:01:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12AA1FC1017161;
        Wed, 10 Mar 2021 10:01:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Mar 2021 10:01:15 +0000
Date:   Wed, 10 Mar 2021 13:01:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-s390@vger.kernel.org, smatch@vger.kernel.org
Subject: Re: smatch and copy_{to,from}_user return values
Message-ID: <20210310100107.GI21246@kadam>
References: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
 <20210303112046.GB2222@kadam>
 <20210305101434.GI2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305101434.GI2222@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100046
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This turned out way more complicated than I expected...  It's working
now.  Probably I will should filter out the function which return
true/false instead of negative error codes.  I was surprised it
generated so few warnings, which suggests that maybe there is a problem.
No real false positives though (one place had multiple errors so I guess
the EIO trumped the EFAULT).

I'm not sure if it's worth sending emails about these...  But I've added
a new --pedantic option for reviewing new code so this would definitely
qualify for that.

regards,
dan carpenter

kernel/trace/trace_uprobe.c:122 get_user_stack_nth() warn: return -EFAULT instead of '0'
arch/x86/kernel/uprobes.c:1070 arch_uretprobe_hijack_return_addr() warn: return -EFAULT instead of '(-1)'
arch/x86/kernel/fpu/signal.c:33 check_for_xstate() warn: return -EFAULT instead of '(-1)'
arch/x86/kvm/cpuid.c:955 sanity_check_entries() warn: return -EFAULT instead of '1'
fs/coda/pioctl.c:62 coda_pioctl() warn: return -EFAULT instead of '-EINVAL'
ipc/msgutil.c:157 store_msg() warn: return -EFAULT instead of '(-1)'
ipc/msgutil.c:164 store_msg() warn: return -EFAULT instead of '(-1)'
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1966 r871x_get_ap_info() warn: return -EFAULT instead of '-EINVAL'
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:2005 r871x_get_ap_info() warn: return -EFAULT instead of '-EINVAL'
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:2020 r871x_set_pid() warn: return -EFAULT instead of '-EINVAL'
drivers/char/xillybus/xillybus_core.c:1340 xillybus_write() warn: return -EFAULT instead of '-EIO'
drivers/usb/mon/mon_bin.c:282 copy_from_buf() warn: return -EFAULT instead of '-EINVAL'
drivers/misc/bcm-vk/bcm_vk_dev.c:956 bcm_vk_load_image() warn: return -EFAULT instead of '-EACCES'
drivers/misc/sgi-gru/grukdump.c:30 gru_user_copy_handle() warn: return -EFAULT instead of '(-1)'
drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:108 amdgpu_fw_attestation_debugfs_read() warn: return -EFAULT instead of '-EINVAL'
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:126 amdgpu_ras_debugfs_read() warn: return -EFAULT instead of '-EINVAL'
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:173 amdgpu_ras_debugfs_ctrl_parse_data() warn: return -EFAULT instead of '-EINVAL'
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:215 amdgpu_ras_debugfs_ctrl_parse_data() warn: return -EFAULT instead of '-EINVAL'
drivers/scsi/lpfc/lpfc_debugfs.c:2427 lpfc_debugfs_dif_err_write() warn: return -EFAULT instead of '0'
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:3764 debugfs_bist_linkrate_v3_hw_write() warn: return -EFAULT instead of '-EINVAL'
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:3854 debugfs_bist_code_mode_v3_hw_write() warn: return -EFAULT instead of '-EOVERFLOW'
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:3983 debugfs_bist_mode_v3_hw_write() warn: return -EFAULT instead of '-EOVERFLOW'
drivers/crypto/qat/qat_common/adf_ctl_drv.c:100 adf_ctl_alloc_resources() warn: return -EFAULT instead of '-EIO'
drivers/media/pci/ttpci/av7110_hw.c:889 LoadBitmap() warn: return -EFAULT instead of '-EINVAL'
drivers/media/pci/ddbridge/ddbridge-core.c:631 ddb_output_write() warn: return -EFAULT instead of '-EIO'
security/tomoyo/common.c:225 tomoyo_flush() warn: return -EFAULT instead of '0'
