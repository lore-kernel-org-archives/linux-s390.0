Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6DC433FE
	for <linux-s390@archiver.kernel.org>; Tue, 23 Nov 2021 04:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKWEGC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 23:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhKWEGB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 23:06:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3EC061748
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 20:02:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1012244pjc.4
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 20:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=sflh6j00R53ITli5bO2IoAwQaIa8VR/tllaujepF7nQ0McJ6iT2CSZUK7BuB1zU6If
         9CwhHY4WZipWFFT6wSgL9NXJHKzpWx4dzREV1QewVHPXAfe3nZ2ge9ayabqAClcoOtMT
         6CWsvm27gk7VLVryyb3GQ4RxleOrmnBmuKNS+T6GLom6VfHHQqPk8G9iMZiGpJfXA6jD
         WtPXA13msMgztdGrXOYIM1Tv6bLvkl2kjxHbaH2u8afmQwOPoz4TylpBWUlzjs7RiwZQ
         Q7dRhRXUS7ma5L6pdFg1NOadjevEswoXcEKlTQmOlLvpZ8ukBNqCZ65Zu45i5yf8msAV
         Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/ky7DkMfynxz93Jg1Thyokk1eZpzUf1Xl2rDhRoyWA=;
        b=pcC0EO49Bg/qHQKvuEB8nP5RbbAV31bOAoKU0yivuJWvmxbrXDTITS4/DyrESu7ati
         LtiHOW2axYy9hCvmOG/LZPzBICRbmn5UIqmNIXvReJ7duK8E5RAd4yRcvdV5ZxC5a3Ld
         60o9Fl4kgo6al24okLTuFpgo4XaI7of5DVETlTcRxtNxK8JKSpoHJDdV8Zza2YKeSNLZ
         YXBCb2Xv5/c8k+CmgSA5iur5V5uZ2enZAnegwSwjzA5uoN0MsRSPhB4bu+2QxWhDEYiU
         9UmyxWOlvzO/WsBhFsPvzKPqT876mQcFKW47Ux2nq0xTj5apdVdAIdkhKRkjXk7SQNy9
         IS5Q==
X-Gm-Message-State: AOAM531OI0hLjtY6bk4ZeisTV+Z6xS9dj1GtbLewc1gf/QihWEFvqoYc
        iSQVY4eHkEyr4Mjhho419iO/EagZ30NbuTrW6wGn9w==
X-Google-Smtp-Source: ABdhPJxvSLmX3xye88c668D00uWDdnnCeZiY99i/tpK8E6hWm4PH0+Kg/6cCj46QhqqZS8+/hIjz2nKulq2NhEFbIuM=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2663610pjb.93.1637640173575;
 Mon, 22 Nov 2021 20:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-11-hch@lst.de>
In-Reply-To: <20211109083309.584081-11-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 20:02:42 -0800
Message-ID: <CAPcyv4hUSRSVBP_G6z7fPUwvb=3F2q4mrGhmD9A4nez=DrEdWQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] dm-log-writes: add a log_writes_dax_pgoff helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
