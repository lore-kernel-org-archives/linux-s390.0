Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88EC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 02:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B3D6109F
	for <linux-s390@archiver.kernel.org>; Tue,  7 Sep 2021 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhIGCMA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 22:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhIGCMA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 22:12:00 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A38C061575;
        Mon,  6 Sep 2021 19:10:55 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id s71so2774159vke.13;
        Mon, 06 Sep 2021 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=gqblQLOZyF+eItV+8wKN74v+NLRtXbXSy5aKMsEa2LM=;
        b=KmUIT3tNI24M5bY0DZc9I6PxkANeHaN1psnXURWjk8zX9U8saR+P0o8ONnzQIQXfPh
         jhNKMmnzGHMPYFp76QNhAW658sNrTucSAfDU8vNsVYgwxF1eyTaKjfW2ScRI/2S3ng73
         EVBNMboqE1nMeK2WuwJvtfa2mDr+hV8qT2DL8MUHXH6/M3Bq67N86FBz2d7gAtVPvloy
         V0+GrzDF+I/mGnCEu9pIBWTPrcUFU1oeh44VJ+xYG34xklfP9gkTThMetYMZowbjatHU
         ikxTnWAYj5ewnoLfzfTvA7R3J6L3xDt+9ekWpUSaKyT8ORiBl+vUwrzpjtPRgUyx8v9j
         wqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=gqblQLOZyF+eItV+8wKN74v+NLRtXbXSy5aKMsEa2LM=;
        b=UcgyOo2AKB+qnPF+fIPyzMLo/NwvnT/X6J7EExG0x3DCaEAcdl2kHiWIADhh469Oql
         Zm5HpaflsfXFAXGvh4m7wOWXynCFjgjtXHnYT9ihmZroTnzUSw4pgG1uApy4aqzPJy3I
         0J78AZinbI7v3XWGJsNF80sphQ9BH8epPFQ7urH+uZxylDtTkEhUk1fyoq0DJOKsL8fd
         s6s+jNp+xRjpAIBdkYqvhZ1RSrD/4Bibp4XI8/N3sA8r2yq7ZgRqfyYv64TfL1/2Og/A
         9VHNi3Ayw2V7OhEB6bcKANoYq2DbRDGI5TbyQQw0tu/jyFiSonvEydJilxojbSgb4ENY
         LIBw==
X-Gm-Message-State: AOAM531pzUzKD2OvHrmyCZvV+kvE4bOrhoGwfNZzfn635dUxUVmly5q0
        PYTMMu0MIp6RcB1006v2SUrKEDRTNYxznZJBQj0gWzj+
X-Google-Smtp-Source: ABdhPJwqPdxF89RdqqyXNmlJTXGt67XTpL6INlVvqq8VjrVWl0wlljlqWfQsK+GBqC4JT1FpC9wEnZr5LfVDuCliSe4=
X-Received: by 2002:a1f:3095:: with SMTP id w143mr6974707vkw.0.1630980654142;
 Mon, 06 Sep 2021 19:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094927.524106-1-schnelle@linux.ibm.com> <CAHrUA34TK6U4TB34FHejott9TdFvSgAedOpmro-Uj2ZwnvzecQ@mail.gmail.com>
In-Reply-To: <CAHrUA34TK6U4TB34FHejott9TdFvSgAedOpmro-Uj2ZwnvzecQ@mail.gmail.com>
Reply-To: linasvepstas@gmail.com
From:   Linas Vepstas <linasvepstas@gmail.com>
Date:   Mon, 6 Sep 2021 21:10:42 -0500
Message-ID: <CAHrUA35pTXpmcQKwFN=mgE+qFD9nNp=9QcB-VZCs9+0=6T3QcQ@mail.gmail.com>
Subject: Fwd: [PATCH 0/5] s390/pci: automatic error recovery
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Ooops, try again without the html. --linas

---------- Forwarded message ---------
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Mon, Sep 6, 2021 at 9:05 PM
Subject: Re: [PATCH 0/5] s390/pci: automatic error recovery
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran
<oohall@gmail.com>, Russell Currey <ruscur@russell.cc>,
<linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>, Matthew
Rosato <mjrosato@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>




On Mon, Sep 6, 2021 at 4:49 AM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
>  I believe we might be the first
> implementation of PCI device recovery in a virtualized setting requiring us to
> coordinate the device reset with the hypervisor platform by issuing a disable
> and re-enable to the platform as well as starting the recovery following
> a platform event.


I recall none of the details, but SRIOV is a standardized system for
sharing a PCI device across multiple virtual machines. It has detailed
info on what the hypervisor must do, and what the local OS instance
must do to accomplish this.  It's part of the PCI standard, and its
more than a decade old now, maybe two. Being a part of the PCI
standard, it was interoperable with error recovery, to the best of my
recollection. At the time it was introduced, it got pushed very
aggressively.  The x86 hypervisor vendors were aiming at the heart of
zseries, and were militant about it.

-- Linas

-- 
Patrick: Are they laughing at us?
Sponge Bob: No, Patrick, they are laughing next to us.




-- 
Patrick: Are they laughing at us?
Sponge Bob: No, Patrick, they are laughing next to us.
