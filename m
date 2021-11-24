Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633FC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 24 Nov 2021 03:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbhKXDye (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Nov 2021 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbhKXDyd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 22:54:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C1C061574
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 19:51:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so3904171pjb.2
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 19:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=vNWAOXzyAyZLL55qsyuCit1K8cMla9Q+I7a8HbLHArMfgpXCYh1wtjdFnUFWSDzn1/
         T1Hm88FkQaWO7xTh0mJLeCLeygQ9XisaZ/XdmwUyLak3fa4OobGb1BWM5ZwyXtbfybYZ
         AImH8X7vgDZd94f4gGyAHjFhglD+WoYohpNRn3ZnIE+uI745TpScjyc77ErLiPREiHK9
         9zQlfvf5/9sPOSgOLuvsV+WpFV/QM4YFfAdVMzyOtae7ikCAA2NGiOEOPGZF9XEqRun2
         JjRU5WwiL+LDDdZvrMhOHyatQOMmuQaQU9bgUORS8BfRoMg++/EVDk/zAuYjdunbyyUb
         o34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJJrE2V7YDKia68Ncdl0fsAelSVdGw1v9JUEXR7xY5Y=;
        b=nCcrW78f0CWtk9FeeOq8ciuoW22feiGwmOZ1v/C+gkkAs0slWxSJ7n/wzmJapcJBOm
         WyCy32+0opfhk+GlDUwWrb5iN2uSeHANR1L2T9oTEylSLIYVuhesGyMQPtv0mqX9NLUI
         p210bBxElpUyZLz7dMciHi5eNqbWraLJFuwAVq22XeftPmwT76210w+j3iUTpn9PsYV8
         VvjoRonU9OcSLIHxgVR5PmXXxL1EpXS8hkqHN/qbdzMy3+NucFrt6/4TalA9xGBxkBBi
         H/zDlO8/4SqxS6iovvT+AiQfYx5i3Czgs4hwSrXLDAp666QAW83wxbZNdvINX+2sLM6x
         /8CA==
X-Gm-Message-State: AOAM533SLZC2bz1mcemqx1xjs6lLbuDiiL1yJHeEjvT191zU+hmOV5xU
        02lgjPeYj2Mq9qeYXbEoaqvxYdWYZ1QJkPee5luWng==
X-Google-Smtp-Source: ABdhPJzAHmbz7abbV3IfUPlG+M3Adum2An1EImXm+0nyzeG+6b50syE8SI9jQ3gftFqA5yglDnQ0v4N9/X3Fjpc01Ms=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr4029053pjb.93.1637725884625;
 Tue, 23 Nov 2021 19:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-29-hch@lst.de>
In-Reply-To: <20211109083309.584081-29-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:51:14 -0800
Message-ID: <CAPcyv4iV+PTdvV+Tq5j3nR6UWFQPTeuzQrZGdS24HdVehY_OaA@mail.gmail.com>
Subject: Re: [PATCH 28/29] iomap: build the block based code conditionally
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
> that is always the case, but it will change soon.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
