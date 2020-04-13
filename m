Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34828 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgDMNlu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 09:41:50 -0400
Date: Mon, 13 Apr 2020 15:41:47 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/10] block: cleanup hd_struct freeing
Message-ID: <20200413134147.GA16386@lst.de>
References: <20200408194439.1580699-1-hch@lst.de> <20200408194439.1580699-4-hch@lst.de> <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On Thu, Apr 09, 2020 at 11:30:19AM +0000, Johannes Thumshirn wrote:
> On 08/04/2020 21:45, Christoph Hellwig wrote:
> > -	struct hd_struct *part = container_of(to_rcu_work(work), struct hd_struct,
> > -					rcu_work);
> > +	struct hd_struct *part =
> > +		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
> 
> That looks like an unneeded white space only change

It was intentional as I was touching the code right next to it anyway..
