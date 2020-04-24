Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726806AbgDXNhX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 09:37:23 -0400
Date: Fri, 24 Apr 2020 08:37:09 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
Message-ID: <20200424133709.egffplf3ewrc4leg@treble>
References: <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad>
 <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble>
 <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble>
 <20200423232657.7minzcsysnhp474w@treble>
 <eb464a0b-922b-1dbd-81e6-1161a5157acb@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb464a0b-922b-1dbd-81e6-1161a5157acb@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, Joe Lawrence <joe.lawrence@redhat.com>

On Fri, Apr 24, 2020 at 09:20:24AM +0200, Christian Borntraeger wrote:
> > Here's a fix, using write() for the PLT and the GOT.
> 
> Are you going to provide a proper patch?

Yes.  These incremental patches are intended to be part of the
discussion, feel free to ignore them.

-- 
Josh
