Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/1] drivers:s390: use setup_timer
References: <1505996458-11714-1-git-send-email-allen.lkml@gmail.com>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 15:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <1505996458-11714-1-git-send-email-allen.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <33028d23-c123-51e0-db93-e38f29692bef@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Allen Pais <allen.lkml@gmail.com>, linux-kernel@vger.kernel.org
Cc: ubraun@linux.vnet.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09/21/2017 02:20 PM, Allen Pais wrote:
>     Use setup_timer function instead of initializing timer with the
>     function and data fields.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Thanks Allen, queued up for our next upstream submission.
