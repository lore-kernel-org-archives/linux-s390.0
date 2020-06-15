Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Jun 2020 15:17:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200615151727.3c7e9786@oasis.local.home>
In-Reply-To: <20200615114038.GA20708@gondor.apana.org.au>
References: <20200611125144.GA2506@gondor.apana.org.au>
        <20200613122834.GA23739@xsang-OptiPlex-9020>
        <20200613130949.GA22005@gondor.apana.org.au>
        <20200613142901.65xieioomt6bbqa6@ltop.local>
        <20200615114038.GA20708@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org

On Mon, 15 Jun 2020 21:40:38 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Thanks for investigating.  I now realise that this was sent against
> my first patch which did have this problem, which was fixed in my
> second patch.  Sorry for the false alarm.

Which is why it is recommended that new patches start their own threads ;-)

That said,

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

for the v2 patch.

-- Steve
