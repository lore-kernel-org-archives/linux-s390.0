Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389902AbfJ2QSB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 12:18:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TFqitd038945
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 12:18:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxp7rqp7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 12:18:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 29 Oct 2019 16:17:58 -0000
Date: Tue, 29 Oct 2019 17:17:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 3/3] s390/livepatch: Implement reliable stack tracing
 for the consistency model
References: <20191029143904.24051-1-mbenes@suse.cz>
 <20191029143904.24051-4-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029143904.24051-4-mbenes@suse.cz>
Message-Id: <20191029161751.GH5646@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

Hi Miroslav,

> +bool unwind_next_frame_reliable(struct unwind_state *state)
> +{
...
> +}
> +
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>  		    struct pt_regs *regs, unsigned long sp,
>  		    bool unwind_reliable)

Did you send the wrong version of your patch series? This patch does
not integrate your new function into the existing one. Also the new
parameter you added with the second patch isn't used at all.
