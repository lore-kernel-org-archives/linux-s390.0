Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A0C43334
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiGKJx0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiGKJxC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 05:53:02 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FAADD4E
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:25:25 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id q26so1936935vsp.11
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjH9Mhj+s0EFpkFHoVD9n2gm+HlpnhoWo+gN6SGoRmE=;
        b=E+2/dLr0JVdgh8vJJowZ1Ih1Gc8YAXOs+wt5KS2GlFjmEqBHuBm+Pr3ZbGTqQqHo/8
         5+g8w7lObXFZkcp+PIB7OvGs501Ekc7pw0s+d3ZHAMtNCfXx2SBu7o+eTu2aeMvQAT88
         Y2WwByqcE5vNupEDETtaBMWmZPf59aUdov8X3U/sRNI9SOrUWW2TkWpWxyszGKgpOmIS
         NV0qVnCyVuCFDgv8qZ/zQ2WIMH8uNp2ebKn5jeBNbWKx0L7r0hklT6q4gQlExF8eDxhR
         NZb5u+UHiTJqdvSO7Wkza23kBg0O+6TaSrMkIryWJqR5Q96ZXAY004N961v+l45/vRAG
         MprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjH9Mhj+s0EFpkFHoVD9n2gm+HlpnhoWo+gN6SGoRmE=;
        b=or3UCyYRbr6/QdqDrxW7N+sbosE2bLk43evCtZpAxi3dUO8mWv48B+/HXeW9CCGrUj
         kMoZRok6+JQ2brfZyWhLK1S0w7Xuv0fM+goaD1wiueeXDEX7SmSJRUoriD7+DEjBN8u1
         aXl0AxbG/XybHK8t8xENdfOwsmRGmDXrorvHX+hgKLonXXfLWhzoOzn9G0mS5TMDSvxs
         JngAP/Xs4QVZnQg0mzKLyDptP+tMdRjTlW+bW3KkxOjAumUlQYczv9mnjXS3BP09OcLB
         8pxl4oqplCq1ufXUFr6IYvGByawG1pylfr7JBds1QrEMjGFarhwpSFfXsllMKhhus31c
         dWQg==
X-Gm-Message-State: AJIora9IkXJbolDciBSOaH5wCm3hjVobMrsifyOq7HNzPIHR/1xyvg1n
        fCwqgH8nqLlegumDNl1PVMlq13zCoPmTrXrXPvc=
X-Google-Smtp-Source: AGRyM1vW73V16m6nqRofn3G41gCQYuFaJ9wJJG84T73Xj1YWaC9KjyKW8N/MCnMO2a/NE0IUnJdbpYue/iSdCxvhydE=
X-Received: by 2002:a05:6102:2411:b0:357:3349:b305 with SMTP id
 j17-20020a056102241100b003573349b305mr6060869vsi.5.1657531524065; Mon, 11 Jul
 2022 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220711074418.858843-1-svens@linux.ibm.com> <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
 <yt9d35f857ue.fsf@linux.ibm.com>
In-Reply-To: <yt9d35f857ue.fsf@linux.ibm.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 11 Jul 2022 12:25:08 +0300
Message-ID: <CAPpZLN4LYUs4UrQ7EpAUcsh2qNJnaV9JHZKBJ-RUUkrU_1d73A@mail.gmail.com>
Subject: Re: [PATCH] trace-cmd: fix writing of uncompressed size
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 11, 2022 at 12:14 PM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Tzvetomir Stoyanov <tz.stoyanov@gmail.com> writes:
>
> > On Mon, Jul 11, 2022 at 10:44 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> >>
> >> Pass &size instead of &handle->pointer. Interestingly this doesn't hurt
> >> on x86, but makes trace-cmd fail on s390.
> >
> > Hi Sven,
> > Thanks for testing this code on s390, I've tested it only on x86.
> > Please, can you give more information about the trace-cmd failure on
> > s390?
> >
> >>
> >> Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >>  lib/trace-cmd/trace-compress.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
> >> index a63295e..ad9b7fc 100644
> >> --- a/lib/trace-cmd/trace-compress.c
> >> +++ b/lib/trace-cmd/trace-compress.c
> >> @@ -331,7 +331,7 @@ int tracecmd_compress_block(struct tracecmd_compression *handle)
> >>                 goto out;
> >>
> >>         /* Write uncompressed data size */
> >> -       endian4 = tep_read_number(handle->tep, &handle->pointer, 4);
> >> +       endian4 = tep_read_number(handle->tep, &size, 4);
> >
> > Here 'size' is the size of the buffer, used by the compression
> > algorithm to compress the data block. That size depends on the
> > algorithm, but usually it is less than the uncompressed data size and
> > bigger than the compressed data size. On this position in the file
> > must be written the size of the uncompressed data, that is
> > 'handle->pointer'. I agree that the name is a bit misleading, as this
> > is not a pointer to a memory address.  The 'handle->pointer' is the
> > offset within the compression buffer, where the next uncompressed data
> > will be written. The logic uses a dynamic buffer with given capacity.
> > When the buffer is empty, 'handle->pointer' is 0. With each
> > uncompressed data chunk, written into that buffer, 'handle->pointer'
> > increases with its size - i.e. the first byte is written on position 0
> > (the initial 'handle->pointer') and the pointer increases to 1. That's
> > why it reflects the size of the uncompressed data. When the pointer
> > reaches the capacity of the buffer, the buffer is extended. At the
> > end, that buffer is passed to the compression algorithm, to compress
> > the block.
>
> I see that 'handle->pointer' is unsigned long, which is 8 bytes on
> s390. But it is converted as 4 byte int. That would work on LE
> platforms, but not on BE.

Yes, that looks like a problem. I think the best fix is to change
'handle->pointer' to unsigned int, can you test that on s390? There is
no need of 8 bytes for that size, unsigned int should be OK. This is
the size of one data chunk, it should not exceed 4G. Do you want to
submit such a fix, if it works on s390?
Thanks Sven!


-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
