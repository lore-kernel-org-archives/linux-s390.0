Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 04 Jul 2018 21:07:35 +0800
From: Huaisheng Ye <yehs2007@zoho.com>
Reply-To: yehs2007@zoho.com
Message-ID: <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
In-Reply-To: <20180704113012.trnfzeefao25clri@quack2.suse.cz>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com> <20180704113012.trnfzeefao25clri@quack2.suse.cz>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access
 if useless
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: "\"Jan Kara\"" <jack@suse.cz>
Cc: linux-nvdimm@lists.01.org, dan.j.williams@intel.com, ross.zwisler@linux.intel.com, mawilcox@microsoft.com, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.com, chengnt@lenovo.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, "\"Huaisheng Ye\"" <yehs1@lenovo.com>, "\"colyli\"" <colyli@suse.de>
List-ID: <linux-s390.vger.kernel.org>

 ---- On Wed, 04 Jul 2018 19:30:12 +0800 Jan Kara <jack@suse.cz> wrote ---- 
 > On Wed 04-07-18 14:40:58, Huaisheng Ye wrote: 
 > > From: Huaisheng Ye <yehs1@lenovo.com> 
 > >  
 > > Some functions within fs/dax don't need to get gfn from direct_access. 
 > > Assigning NULL to gfn of dax_direct_access is more intuitive and simple 
 > > than offering a useless local variable. 
 > >  
 > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com> 
 >  
 > I like this. You can add: 
 >  
 > Reviewed-by: Jan Kara <jack@suse.cz> 
 >  
 > for the series. 
 >  
 >                                 Honza 
 >  
I am so happy you like them, thank you very much.

---
Cheers,
Huaisheng
