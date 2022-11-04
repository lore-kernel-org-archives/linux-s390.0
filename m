Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864DFC4332F
	for <linux-s390@archiver.kernel.org>; Fri,  4 Nov 2022 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKDRG7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKDRGu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Nov 2022 13:06:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD731FA0
        for <linux-s390@vger.kernel.org>; Fri,  4 Nov 2022 10:06:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h24so3400085qta.7
        for <linux-s390@vger.kernel.org>; Fri, 04 Nov 2022 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=TyCMiI4ARMPxd18RVlEv+qm2LWR7zC104Hlivn40qb5lZJslIeDFuCNMNvjneFE/Nj
         LFwCX5vAwmEX/R8qjGO9x9K9/hgdwoRd2q59WUqMzWoiDvISQjer+tTT1jJ7UfSLA8Vn
         fR3VeAjk206NeR5DC2lSXJH82ZME8JVM9jplc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=4/8sej3oRVMETlmr2AhSJlMXNsoscg/kDrWuHSUOFbtzNRYzDZiZnIzTJigXfN2NkQ
         GgUW6efFFBpXoc7mUKAm+Mxp9Y41z9fuDlQfu69RI6z2IUv/RC+N86RuGjjELA18lB/I
         qZDjchb18y1woywzQYJzDhyo/5GCG2740o8XPSWT1TmKZwd2uhxNjgr16nZtbp3eQcwe
         2utrr+cF2+C45Q/wKxj51eQD7Ggu1PW7sbFEeh0xgVnmBHX+9NhaZahR4PnIjEV6xJTE
         c+sOkTiVBjMZeSxZmRyMvn/ZtFbUjAPLbTTuZ8cecimRd4BjpA/ryEb1B5zFBqTNTcgx
         Hxyw==
X-Gm-Message-State: ACrzQf20Hdlk7T8AbTjBiBIHZMm8hQ/nN7QIU2QrkOEoPkdSUhIiyo6e
        ROPkkksPninHBeymKjPJ0r2SiF2JdPXdGQ==
X-Google-Smtp-Source: AMsMyM5GGNh11+newElyatelwKeqCOoKr/Fuqxmi36PopwLlaS6IzcUeoUWFpOMEyZIo0xfz+BYaVg==
X-Received: by 2002:ac8:4a02:0:b0:3a5:311f:2ee0 with SMTP id x2-20020ac84a02000000b003a5311f2ee0mr20471931qtq.347.1667581605499;
        Fri, 04 Nov 2022 10:06:45 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id t22-20020a05620a451600b006f87d28ea3asm3289397qkp.54.2022.11.04.10.06.45
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:06:45 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id k13so2691555ybk.2
        for <linux-s390@vger.kernel.org>; Fri, 04 Nov 2022 10:06:45 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr27409344ywf.441.1667581219811; Fri, 04
 Nov 2022 10:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org>
In-Reply-To: <20221104054053.431922658@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 10:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 00/33] timers: Use timer_shutdown*() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 3, 2022 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Ideally, I would have the first patch go into this rc cycle, which is mostly
> non functional as it will allow the other patches to come in via the respective
> subsystems in the next merge window.

Ack.

I also wonder if we could do the completely trivially correct
conversions immediately.

I'm talking about the scripted ones where it's currently a
"del_timer_sync()", and the very next action is freeing whatever data
structure the timer is in (possibly with something like free_irq() in
between - my point is that there's an unconditional free that is very
clear and unambiguous), so that there is absolutely no question about
whether they should use "timer_shutdown_sync()" or not.

IOW, things like patches 03, 17 and 31, and at least parts others in
this series.

This series clearly has several much more complex cases that need
actual real code review, and I think it would help to have the
completely unambiguous cases out of the way, just to get rid of noise.

So I'd take that first patch, and a scripted set of "this cannot
change any semantics" patches early.

                Linus
